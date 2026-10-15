import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient db = Supabase.instance.client;

  Future<void> signIn(String email, String password) async {
    await db.auth.signInWithPassword(email: email.trim(), password: password);
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await db.auth.signUp(
      email: email.trim(),
      password: password,
      data: {
        'full_name': name.trim(),
        'phone': phone.trim(),
        'role': 'user',
      },
    );
  }

  Future<void> signUpDoctor({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String professionalCard,
    required String specialty,
  }) async {
    await db.auth.signUp(
      email: email.trim(),
      password: password,
      data: {
        'full_name': name.trim(),
        'phone': phone.trim(),
        'role': 'doctor',
        'professional_card': professionalCard.trim(),
        'specialty': specialty.trim(),
      },
    );
  }

  Future<void> resetPassword(String email) async {
    await db.auth.resetPasswordForEmail(email.trim());
  }

  Future<void> signOut() async {
    await db.auth.signOut();
  }
}
