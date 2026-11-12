import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_role_screen.dart';

class GuestAccessScreen extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const GuestAccessScreen({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.lock_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 76, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 18),
              Text(title, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(description, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterRoleScreen()),
                ),
                icon: const Icon(Icons.person_add_alt_1),
                label: const Text('Crear cuenta para continuar'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                icon: const Icon(Icons.login),
                label: const Text('Ya tengo cuenta · Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
