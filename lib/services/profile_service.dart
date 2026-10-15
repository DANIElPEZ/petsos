import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.dart';

class ProfileService {
  final SupabaseClient db = Supabase.instance.client;

  Future<Profile> getMyProfile() async {
    final id = db.auth.currentUser!.id;
    final data = await db.from('profiles').select().eq('id', id).single();
    return Profile.fromMap(data);
  }

  Future<List<Profile>> getDoctors() async {
    final data = await db
        .from('profiles')
        .select()
        .eq('role', 'doctor')
        .order('full_name');
    return (data as List)
        .map((e) => Profile.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
