import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dog.dart';

class DogService {
  final SupabaseClient db = Supabase.instance.client;

  Future<List<Dog>> getMyDogs() async {
    final data = await db
        .from('dogs')
        .select()
        .eq('owner_id', db.auth.currentUser!.id)
        .order('created_at', ascending: false);
    return (data as List)
        .map((e) => Dog.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createDog({
    required String name,
    String? breed,
    String? sex,
    int? age,
    String? color,
    String? description,
    List<String> images = const [],
  }) async {
    await db.from('dogs').insert({
      'owner_id': db.auth.currentUser!.id,
      'name': name.trim(),
      'breed': breed?.trim(),
      'sex': sex?.trim(),
      'age': age,
      'color': color?.trim(),
      'description': description?.trim(),
      'images': images,
    });
  }

  Future<void> updateDog({
    required String id,
    required String name,
    String? breed,
    String? sex,
    int? age,
    String? color,
    String? description,
    List<String> images = const [],
  }) async {
    await db.from('dogs').update({
      'name': name.trim(),
      'breed': breed?.trim(),
      'sex': sex?.trim(),
      'age': age,
      'color': color?.trim(),
      'description': description?.trim(),
      'images': images,
    }).eq('id', id);
  }

  Future<void> deleteDog(String id) async {
    await db.from('dogs').delete().eq('id', id);
  }
}
