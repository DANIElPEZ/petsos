import 'package:flutter/material.dart';
import '../../models/dog.dart';
import '../../services/dog_service.dart';
import '../../widgets/dog_card.dart';
import 'add_dog_screen.dart';
import 'dog_detail_screen.dart';

class DogsScreen extends StatefulWidget {
  const DogsScreen({super.key});

  @override
  State<DogsScreen> createState() => _DogsScreenState();
}

class _DogsScreenState extends State<DogsScreen> {
  List<Dog> dogs = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() => loading = true);
    try {
      dogs = await DogService().getMyDogs();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis mascotas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddDogScreen()));
          load();
        },
        icon: const Icon(Icons.add),
        label: const Text('Agregar mascota'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : dogs.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.pets, size: 70),
                        const SizedBox(height: 12),
                        const Text('Aún no tienes mascotas registradas', textAlign: TextAlign.center),
                        const SizedBox(height: 15),
                        FilledButton.icon(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddDogScreen())).then((_) => load()),
                          icon: const Icon(Icons.add),
                          label: const Text('Registrar mascota'),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: load,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: dogs.length,
                    itemBuilder: (_, i) => DogCard(
                      dog: dogs[i],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DogDetailScreen(dog: dogs[i])),
                      ).then((_) => load()),
                    ),
                  ),
                ),
    );
  }
}
