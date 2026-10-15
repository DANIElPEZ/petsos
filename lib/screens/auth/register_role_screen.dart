import 'package:flutter/material.dart';
import 'register_user_screen.dart';
import 'register_doctor_screen.dart';

class RegisterRoleScreen extends StatelessWidget {
  const RegisterRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            '¿Cómo usarás PetsOS?',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.pets)),
              title: const Text('Soy dueño de una mascota'),
              subtitle: const Text('Registrar perros y usar SOS.'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterUserScreen()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.medical_services)),
              title: const Text('Soy veterinario'),
              subtitle: const Text('Recibir y atender solicitudes médicas.'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterDoctorScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
