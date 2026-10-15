import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../widgets/primary_button.dart';
import 'register_role_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  Future<void> login() async {
    if (email.text.trim().isEmpty || password.text.isEmpty) return;
    setState(() => loading = true);
    try {
      await AuthService().signIn(email.text, password.text);
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (_) => false,
      );
    } catch (e) {
      if (mounted) _showError(e.toString());
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  const Icon(Icons.pets, size: 80, color: Colors.green),
                  const SizedBox(height: 12),
                  const Text('PetsOS',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  const Text('Tu mascota. Tu prioridad.'),
                  const SizedBox(height: 40),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    text: loading ? 'Ingresando...' : 'Iniciar sesión',
                    icon: Icons.login,
                    onPressed: loading ? null : login,
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      if (email.text.trim().isEmpty) {
                        _showError('Escribe tu correo primero.');
                        return;
                      }
                      try {
                        await AuthService().resetPassword(email.text);
                        if (mounted) _showError('Revisa tu correo.');
                      } catch (e) {
                        if (mounted) _showError(e.toString());
                      }
                    },
                    child: const Text('¿Olvidaste tu contraseña?'),
                  ),
                  const Divider(height: 30),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterRoleScreen(),
                        ),
                      );
                    },
                    child: const Text('Crear cuenta'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
