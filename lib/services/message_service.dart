import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message.dart';

class MessageService {
  final SupabaseClient db = Supabase.instance.client;

  Future<List<ChatMessage>> getMessages(String requestId) async {
    final data = await db
        .from('messages')
        .select()
        .eq('request_id', requestId)
        .order('created_at');
    return (data as List)
        .map((e) => ChatMessage.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> sendMessage({
    required String requestId,
    String? text,
    List<String> images = const [],
  }) async {
    await db.from('messages').insert({
      'request_id': requestId,
      'sender_id': db.auth.currentUser!.id,
      'message': text?.trim(),
      'images': images,
    });
  }

  Stream<List<Map<String, dynamic>>> watchMessages(String requestId) {
    return db
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('request_id', requestId)
        .order('created_at');
  }
}
