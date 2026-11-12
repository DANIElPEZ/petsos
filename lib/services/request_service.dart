import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/request_model.dart';

class RequestService {
  final SupabaseClient db = Supabase.instance.client;

  Future<void> createRequest({
    required String dogId,
    required String type,
    String? description,
    List<String> images = const [],
    String? location,
    double? latitude,
    double? longitude,
    double reward = 0,
  }) async {
    await db.from('requests').insert({
      'user_id': db.auth.currentUser!.id,
      'dog_id': dogId,
      'type': type,
      'description': description?.trim(),
      'images': images,
      'location': location?.trim(),
      'latitude': latitude,
      'longitude': longitude,
      'reward': reward,
      'status': 'active',
    });
  }

  Future<List<PetRequest>> getLostRequests() async {
    final data = await db
        .from('requests')
        .select('*, dogs(*)')
        .eq('type', 'lost')
        .eq('status', 'active')
        .order('created_at', ascending: false);
    return (data as List)
        .map((e) => PetRequest.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<PetRequest>> getMyRequests() async {
    final id = db.auth.currentUser!.id;
    final data = await db
        .from('requests')
        .select('*, dogs(*)')
        .or('user_id.eq.$id,doctor_id.eq.$id,finder_id.eq.$id')
        .order('created_at', ascending: false);
    return (data as List)
        .map((e) => PetRequest.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<PetRequest>> getMedicalRequests() async {
    final data = await db
        .from('requests')
        .select('*, dogs(*)')
        .eq('type', 'medical')
        .eq('status', 'active')
        .order('created_at', ascending: false);
    return (data as List)
        .map((e) => PetRequest.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> acceptMedicalRequest(String requestId) async {
    await db.from('requests').update({
      'doctor_id': db.auth.currentUser!.id,
      'status': 'accepted',
    }).eq('id', requestId);
  }

  Future<void> completeRequest(String requestId) async {
    await db.from('requests').update({
      'status': 'completed',
      'completed_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', requestId);
  }

  Future<void> markLostAsFound(String requestId, {String? finderId}) async {
    await db.from('requests').update({
      'status': 'found',
      'completed_at': DateTime.now().toUtc().toIso8601String(),
      if (finderId != null) 'finder_id': finderId,
    }).eq('id', requestId);
  }

  Future<void> setFinder(String requestId) async {
    await db.from('requests').update({
      'finder_id': db.auth.currentUser!.id,
    }).eq('id', requestId);
  }

  Future<void> submitFeedback({
    required String requestId,
    required String serviceType,
    required int rating,
    String? comment,
  }) async {
    final userId = db.auth.currentUser?.id;
    if (userId == null) throw Exception('Debes iniciar sesión para enviar tu opinión.');
    await db.from('service_feedback').insert({
      'request_id': requestId,
      'user_id': userId,
      'service_type': serviceType,
      'rating': rating,
      'comment': comment?.trim().isEmpty == true ? null : comment?.trim(),
    });
  }
}
