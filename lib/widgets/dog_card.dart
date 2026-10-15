import 'package:flutter/material.dart';
import '../models/dog.dart';

class DogCard extends StatelessWidget {
  final Dog dog;
  final VoidCallback onTap;

  const DogCard({super.key, required this.dog, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage:
              dog.mainImage.isNotEmpty ? NetworkImage(dog.mainImage) : null,
          child: dog.mainImage.isEmpty ? const Icon(Icons.pets) : null,
        ),
        title: Text(dog.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(dog.breed ?? 'Raza no registrada'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
