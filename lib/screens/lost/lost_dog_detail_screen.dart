import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/request_model.dart';
import '../../services/request_service.dart';
import '../auth/guest_access_screen.dart';
import '../chat/chat_screen.dart';
import '../feedback/service_feedback_screen.dart';

class LostDogDetailScreen extends StatelessWidget {
  final PetRequest request;

  const LostDogDetailScreen({super.key, required this.request});

  Future<void> contact(BuildContext context) async {
    final currentId = Supabase.instance.client.auth.currentUser?.id;
    if (currentId == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const GuestAccessScreen(
            title: 'Contactar a la comunidad',
            description: 'Crea una cuenta o inicia sesión para contactar al responsable de esta alerta.',
            icon: Icons.chat,
          ),
        ),
      );
      return;
    }
    try {
      if (request.userId != currentId && request.finderId == null) {
        await RequestService().setFinder(request.id);
      }
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChatScreen(request: request)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  Future<void> markAsFound(BuildContext context) async {
    try {
      await RequestService().markLostAsFound(request.id);
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ServiceFeedbackScreen(requestId: request.id, serviceType: 'lost'),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dog = request.dog;
    final currentId = Supabase.instance.client.auth.currentUser?.id;
    final isOwner = currentId != null && request.userId == currentId;
    return Scaffold(
      appBar: AppBar(title: Text(dog?.name ?? 'Mascota perdida')),
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            child: dog == null || dog.images.isEmpty
                ? const Center(child: Icon(Icons.pets, size: 100))
                : PageView(children: dog.images.map((url) => Image.network(url, fit: BoxFit.cover)).toList()),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dog?.name ?? 'Mascota', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text('${dog?.petType ?? 'Mascota'} · ${dog?.breed ?? 'Raza/variedad no registrada'}'),
                const SizedBox(height: 16),
                if (dog?.sex != null) Text('Sexo: ${dog!.sex}'),
                if (dog?.color != null) Text('Color: ${dog!.color}'),
                if (request.location != null) Text('📍 Última ubicación: ${request.location}'),
                const SizedBox(height: 16),
                Text('💰 Recompensa ofrecida: \$${request.reward.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(request.description ?? 'Sin descripción.'),
                const SizedBox(height: 25),
                if (isOwner && request.status == 'active')
                  FilledButton.icon(
                    onPressed: () => markAsFound(context),
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('MARCAR COMO ENCONTRADA Y CALIFICAR'),
                  )
                else if (request.status == 'found' && isOwner)
                  FilledButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceFeedbackScreen(requestId: request.id, serviceType: 'lost'),
                      ),
                    ),
                    icon: const Icon(Icons.star_outline),
                    label: const Text('CALIFICAR SERVICIO'),
                  )
                else if (request.status == 'found')
                  const Chip(label: Text('Esta alerta fue cerrada'))
                else
                  FilledButton.icon(
                    onPressed: () => contact(context),
                    icon: const Icon(Icons.chat),
                    label: const Text('LO ENCONTRÉ / CONTACTAR'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
