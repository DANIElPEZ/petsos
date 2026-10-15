import 'package:flutter/material.dart';
import '../models/request_model.dart';

class LostRequestCard extends StatelessWidget {
  final PetRequest request;
  final VoidCallback onTap;

  const LostRequestCard({
    super.key,
    required this.request,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dog = request.dog;
    final image = dog?.mainImage ?? '';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 190,
              width: double.infinity,
              child: image.isEmpty
                  ? const Center(child: Icon(Icons.pets, size: 70))
                  : Image.network(image, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dog?.name ?? 'Mascota',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(dog?.breed ?? 'Raza no registrada'),
                  const SizedBox(height: 8),
                  if (request.location != null)
                    Text('📍 ${request.location}'),
                  Text(
                    '💰 Recompensa: \$${request.reward.toStringAsFixed(0)}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
