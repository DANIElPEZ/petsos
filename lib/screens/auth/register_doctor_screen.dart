import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/auth_service.dart';
import '../../widgets/primary_button.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';

class RegisterDoctorScreen extends StatefulWidget {
  const RegisterDoctorScreen({super.key});

  @override
  State<RegisterDoctorScreen> createState() => _RegisterDoctorScreenState();
}

class _RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  final card = TextEditingController();
  final specialty = TextEditingController();
  bool loading = false;

  Future<void> register() async {
    if (name.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        password.text.isEmpty) {
      return;
    }
    if (password.text != confirm.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.')),
      );
      return;
    }

    setState(() => loading = true);
    try {
      await AuthService().signUpDoctor(
        name: name.text,
        email: email.text,
        phone: phone.text,
        password: password.text,
        professionalCard: card.text,
        specialty: specialty.text,
      );
      if (!mounted) return;
      if (Supabase.instance.client.auth.currentSession == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cuenta creada. Revisa tu correo para confirmar la cuenta.')),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (_) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (_) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro veterinario')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Información profesional',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Nombre completo')),
          const SizedBox(height: 12),
          TextField(controller: email, decoration: const InputDecoration(labelText: 'Correo')),
          const SizedBox(height: 12),
          TextField(controller: phone, decoration: const InputDecoration(labelText: 'Teléfono')),
          const SizedBox(height: 12),
          TextField(controller: card, decoration: const InputDecoration(labelText: 'Tarjeta profesional')),
          const SizedBox(height: 12),
          TextField(controller: specialty, decoration: const InputDecoration(labelText: 'Especialidad')),
          const SizedBox(height: 12),
          TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Contraseña')),
          const SizedBox(height: 12),
          TextField(controller: confirm, obscureText: true, decoration: const InputDecoration(labelText: 'Confirmar contraseña')),
          const SizedBox(height: 24),
          PrimaryButton(text: loading ? 'Creando...' : 'Crear cuenta', onPressed: loading ? null : register),
        ],
      ),
    );
  }
}
