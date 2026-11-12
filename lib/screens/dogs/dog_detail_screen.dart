import 'package:flutter/material.dart';
import '../../models/dog.dart';
import '../../services/dog_service.dart';
import 'add_dog_screen.dart';

class DogDetailScreen extends StatelessWidget {
  final Dog dog;

  const DogDetailScreen({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dog.name),
        actions: [
          IconButton(
            tooltip: 'Eliminar',
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Eliminar mascota'),
                  content: Text('¿Deseas eliminar a ${dog.name}?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                    FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
                  ],
                ),
              );
              if (ok == true) {
                await DogService().deleteDog(dog.id);
                if (context.mounted) Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 280,
            child: dog.images.isEmpty
                ? const Center(child: Icon(Icons.pets, size: 100))
                : PageView(
                    children: dog.images.map((url) => Image.network(url, fit: BoxFit.cover)).toList(),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dog.name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(dog.breed ?? 'Raza no registrada'),
                const SizedBox(height: 20),
                _Info(label: 'Tipo de mascota', value: dog.petType),
                _Info(label: 'Sexo', value: dog.sex ?? 'No registrado'),
                _Info(label: 'Edad', value: dog.age == null ? 'No registrada' : '${dog.age} años'),
                _Info(label: 'Color', value: dog.color ?? 'No registrado'),
                _Info(label: 'Descripción', value: dog.description ?? 'Sin descripción'),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('La edición avanzada se puede agregar reutilizando el formulario de registro.')),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String label;
  final String value;
  const _Info({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text('$label: $value', style: const TextStyle(fontSize: 16)),
    );
  }
}
