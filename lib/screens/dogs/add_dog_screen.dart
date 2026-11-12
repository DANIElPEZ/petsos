import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/pet_types.dart';
import '../../services/dog_service.dart';
import '../../services/storage_service.dart';
import '../../widgets/primary_button.dart';

class AddDogScreen extends StatefulWidget {
  const AddDogScreen({super.key});

  @override
  State<AddDogScreen> createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final name = TextEditingController();
  final breed = TextEditingController();
  final age = TextEditingController();
  final color = TextEditingController();
  final description = TextEditingController();
  String petType = petTypes.first;
  String sex = 'Macho';
  final List<File> selected = [];
  bool loading = false;

  Future<void> pickImages() async {
    final result = await ImagePicker().pickMultiImage(imageQuality: 80);
    setState(() => selected.addAll(result.map((image) => File(image.path))));
  }

  Future<void> save() async {
    if (name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Escribe el nombre de la mascota.')));
      return;
    }

    setState(() => loading = true);
    try {
      final urls = <String>[];
      for (final file in selected) {
        urls.add(await StorageService().uploadImage(file: file, folder: 'dogs'));
      }

      await DogService().createDog(
        name: name.text,
        petType: petType,
        breed: breed.text,
        sex: sex,
        age: int.tryParse(age.text),
        color: color.text,
        description: description.text,
        images: urls,
      );

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar mascota')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Nombre')),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: petType,
            decoration: const InputDecoration(labelText: 'Tipo de mascota'),
            items: petTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
            onChanged: (value) => setState(() => petType = value ?? petTypes.first),
          ),
          const SizedBox(height: 12),
          TextField(controller: breed, decoration: const InputDecoration(labelText: 'Raza / variedad (opcional)')),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: sex,
            decoration: const InputDecoration(labelText: 'Sexo'),
            items: const [
              DropdownMenuItem(value: 'Macho', child: Text('Macho')),
              DropdownMenuItem(value: 'Hembra', child: Text('Hembra')),
            ],
            onChanged: (v) => setState(() => sex = v ?? 'Macho'),
          ),
          const SizedBox(height: 12),
          TextField(controller: age, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Edad')),
          const SizedBox(height: 12),
          TextField(controller: color, decoration: const InputDecoration(labelText: 'Color')),
          const SizedBox(height: 12),
          TextField(controller: description, maxLines: 3, decoration: const InputDecoration(labelText: 'Descripción / características')),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: pickImages,
            icon: const Icon(Icons.photo_library),
            label: Text('Agregar fotos (${selected.length})'),
          ),
          if (selected.isNotEmpty)
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: selected.map((f) => Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8),
                  child: Image.file(f, width: 100, fit: BoxFit.cover),
                )).toList(),
              ),
            ),
          const SizedBox(height: 20),
          PrimaryButton(text: loading ? 'Guardando...' : 'Guardar perro', icon: Icons.save, onPressed: loading ? null : save),
        ],
      ),
    );
  }
}
