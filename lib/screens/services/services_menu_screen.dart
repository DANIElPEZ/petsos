import 'package:flutter/material.dart';
import '../auth/guest_access_screen.dart';
import '../chat/conversations_screen.dart';
import '../doctor/medical_requests_screen.dart';
import '../doctor/emergency_inbox_screen.dart';
import '../lost/lost_dogs_screen.dart';

class ServicesMenuScreen extends StatelessWidget {
  final bool isGuest;
  final bool isDoctor;

  const ServicesMenuScreen({
    super.key,
    required this.isGuest,
    required this.isDoctor,
  });

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    if (isDoctor && !isGuest) {
      return Scaffold(
        appBar: AppBar(title: const Text('Servicios veterinarios')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Atención a la comunidad',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _ServiceCard(
              icon: Icons.medical_services,
              title: 'Solicitudes médicas',
              description: 'Consulta y atiende reportes de urgencia veterinaria.',
              onTap: () => _open(context, const MedicalRequestsScreen()),
            ),
            _ServiceCard(
              icon: Icons.warning_amber,
              title: 'Alertas SOS',
              description: 'Revisa reportes recibidos incluso desde usuarios invitados o que estaban sin conexión.',
              onTap: () => _open(context, const EmergencyInboxScreen()),
            ),
            _ServiceCard(
              icon: Icons.chat_bubble_outline,
              title: 'Conversaciones',
              description: 'Comunícate con los propietarios que solicitan atención.',
              onTap: () => _open(context, const ConversationsScreen()),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Servicios PetsOS')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('¿Cómo podemos ayudar?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Explora los dos servicios principales de la aplicación.'),
          const SizedBox(height: 18),
          _ServiceCard(
            icon: Icons.public,
            title: 'Alertas de la comunidad',
            description: 'Consulta los reportes activos de mascotas perdidas.',
            onTap: () => _open(context, const LostDogsScreen()),
          ),
          if (!isGuest)
            _ServiceCard(
              icon: Icons.chat_bubble_outline,
              title: 'Mis conversaciones',
              description: 'Da seguimiento a las solicitudes y coordina con la comunidad o el veterinario.',
              onTap: () => _open(context, const ConversationsScreen()),
            ),
          if (isGuest) ...[
            const SizedBox(height: 10),
            const Text(
              'El botón de pánico está disponible sin registro. Para crear y administrar solicitudes desde este menú, deberás iniciar sesión.',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(icon),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(description),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
