import 'package:flutter/material.dart';
import 'create_lost_request_screen.dart';
import 'create_medical_request_screen.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Botón de pánico')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.warning_rounded, size: 75, color: Colors.red),
          const SizedBox(height: 12),
          const Text(
            '¿Qué está ocurriendo?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Selecciona el tipo de emergencia. Puedes enviar el reporte como invitado y también sin conexión.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          _SosOption(
            icon: Icons.search,
            color: Colors.orange,
            title: 'MI MASCOTA ESTÁ PERDIDA',
            subtitle: 'Registra la pérdida y la última ubicación conocida.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateLostRequestScreen()),
            ),
          ),
          const SizedBox(height: 15),
          _SosOption(
            icon: Icons.local_hospital,
            color: Colors.red,
            title: 'EMERGENCIA VETERINARIA',
            subtitle: 'Registra los síntomas y la ubicación de tu mascota.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateMedicalRequestScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _SosOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SosOption({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: color.withOpacity(.12),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    const SizedBox(height: 5),
                    Text(subtitle),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
