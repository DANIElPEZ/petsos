import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/dog.dart';
import '../../services/dog_service.dart';
import '../../services/request_service.dart';
import '../../services/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/guest_access_screen.dart';

class CreateMedicalRequestScreen extends StatefulWidget {
  const CreateMedicalRequestScreen({super.key});

  @override
  State<CreateMedicalRequestScreen> createState() => _CreateMedicalRequestScreenState();
}

class _CreateMedicalRequestScreenState extends State<CreateMedicalRequestScreen> {
  List<Dog> dogs = [];
  Dog? selected;
  final description = TextEditingController();
  final location = TextEditingController();
  final List<File> photos = [];
  bool loading = true;
  bool saving = false;
  bool get authenticated => Supabase.instance.client.auth.currentSession != null;

  @override
  void initState() {
    super.initState();
    loadDogs();
  }

  Future<void> loadDogs() async {
    dogs = await DogService().getMyDogs();
    if (mounted) setState(() {
      selected = dogs.isNotEmpty ? dogs.first : null;
      loading = false;
    });
  }

  Future<void> pickPhotos() async {
    final result = await ImagePicker().pickMultiImage(imageQuality: 80);
    setState(() => photos.addAll(result.map((image) => File(image.path))));
  }

  Future<void> publish() async {
    if (selected == null || description.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona una mascota y describe lo que ocurre.')));
      return;
    }
    setState(() => saving = true);
    try {
      final urls = <String>[];
      for (final f in photos) {
        urls.add(await StorageService().uploadImage(file: f, folder: 'requests'));
      }

      await RequestService().createRequest(
        dogId: selected!.id,
        type: 'medical',
        description: description.text,
        images: urls,
        location: location.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Solicitud enviada a los médicos.')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = !authenticated;

    return isGuest?GuestAccessScreen(
      title: 'Tu perfil PetsOS',
      description: 'Inicia sesión o crea una cuenta para consultar tus datos, mascotas, solicitudes y conversaciones.',
      icon: Icons.account_circle_outlined,
    ): Scaffold(
      appBar: AppBar(title: const Text('Atención veterinaria')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownButtonFormField<Dog>(
            value: selected,
            decoration: const InputDecoration(labelText: '¿Qué mascota necesita atención?'),
            items: dogs.map((dog) => DropdownMenuItem(value: dog, child: Text(dog.name))).toList(),
            onChanged: (v) => setState(() => selected = v),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: description,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: '¿Qué le ocurre?',
              hintText: 'Describe los síntomas...',
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: location,
            decoration: const InputDecoration(
              labelText: 'Ubicación / referencia',
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(onPressed: pickPhotos, icon: const Icon(Icons.photo_library), label: Text('Agregar fotos (${photos.length})')),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: saving ? null : publish,
            icon: const Icon(Icons.medical_services),
            label: Text(saving ? 'Enviando...' : 'PUBLICAR SOLICITUD'),
          ),
        ],
      ),
    );
  }
}
