import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Cola persistente de alertas SOS. SQLite conserva los reportes aunque
/// la aplicación se cierre antes de recuperar internet.
class OfflineSosService {
  OfflineSosService._();

  static final OfflineSosService instance = OfflineSosService._();

  static const String _table = 'pending_sos';
  Database? _localDatabase;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _syncing = false;
  bool _syncAgain = false;

  Future<Database> get _database async {
    if (_localDatabase != null) return _localDatabase!;
    final databasePath = await getDatabasesPath();
    _localDatabase = await openDatabase(
      '$databasePath/petsos_offline.db',
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE $_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            client_id TEXT NOT NULL UNIQUE,
            user_id TEXT,
            emergency_type TEXT NOT NULL,
            pet_name TEXT NOT NULL,
            pet_type TEXT NOT NULL,
            description TEXT NOT NULL,
            contact_phone TEXT,
            location TEXT,
            latitude REAL,
            longitude REAL,
            client_created_at TEXT NOT NULL
          )
        ''');
      },
    );
    return _localDatabase!;
  }

  Future<void> initialize() async {
    _connectivitySubscription ??= Connectivity().onConnectivityChanged.listen(
      (results) {
        if (results.any((result) => result != ConnectivityResult.none)) {
          unawaited(syncPending());
        }
      },
    );
    // No bloquea el arranque de la aplicación si la red está caída.
    unawaited(syncPending());
  }

  Future<int> pendingCount() async {
    final database = await _database;
    final rows = await database.rawQuery('SELECT COUNT(*) AS total FROM $_table');
    return (rows.first['total'] as int?) ?? 0;
  }

  Future<bool> enqueue({
    required String emergencyType,
    required String petName,
    required String petType,
    required String description,
    String? contactPhone,
    String? location,
    double? latitude,
    double? longitude,
  }) async {
    final database = await _database;
    final random = Random.secure();
    final clientId = '${DateTime.now().microsecondsSinceEpoch}-${random.nextInt(1 << 32)}';

    await database.insert(_table, {
      'client_id': clientId,
      'user_id': Supabase.instance.client.auth.currentUser?.id,
      'emergency_type': emergencyType,
      'pet_name': petName.trim(),
      'pet_type': petType,
      'description': description.trim(),
      'contact_phone': _nullable(contactPhone),
      'location': _nullable(location),
      'latitude': latitude,
      'longitude': longitude,
      'client_created_at': DateTime.now().toUtc().toIso8601String(),
    });

    try {
      final connectionTypes = await Connectivity().checkConnectivity();
      if (connectionTypes.any((result) => result != ConnectivityResult.none)) {
        await syncPending();
      }
    } catch (_) {
      // El reporte ya está en SQLite; queda pendiente para el próximo intento.
    }
    final remaining = await database.query(
      _table,
      columns: ['id'],
      where: 'client_id = ?',
      whereArgs: [clientId],
      limit: 1,
    );
    return remaining.isEmpty;
  }

  Future<void> syncPending() async {
    if (_syncing) {
      _syncAgain = true;
      return;
    }
    _syncing = true;
    try {
      do {
        _syncAgain = false;
        final database = await _database;
        final rows = await database.query(_table, orderBy: 'id ASC');
        for (final row in rows) {
          final localId = row['id'] as int;
          final payload = Map<String, dynamic>.from(row)..remove('id');
          try {
            await Supabase.instance.client.from('emergency_events').insert(payload);
            await database.delete(_table, where: 'id = ?', whereArgs: [localId]);
          } on PostgrestException catch (error) {
            // Si se perdió la respuesta después de guardar, client_id evita
            // crear una segunda alerta en Supabase.
            if (error.code == '23505') {
              await database.delete(_table, where: 'id = ?', whereArgs: [localId]);
            } else {
              break;
            }
          } catch (_) {
            // Se conserva esta alerta y las siguientes para el próximo intento.
            break;
          }
        }
      } while (_syncAgain);
    } catch (_) {
      // No se elimina ni modifica la cola si falla la base local o la red.
    } finally {
      _syncing = false;
    }
  }

  String? _nullable(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    await _localDatabase?.close();
    _localDatabase = null;
  }
}
