import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient db = Supabase.instance.client;

  // Crea en Supabase Storage un bucket PUBLIC llamado "petsos".
  Future<String> uploadImage({
    required File file,
    required String folder,
  }) async {
    final extension = file.path.split('.').last.toLowerCase();
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${db.auth.currentUser!.id}.$extension';
    final path = '$folder/$fileName';

    await db.storage.from('petsos').upload(path, file);
    return db.storage.from('petsos').getPublicUrl(path);
  }
}
