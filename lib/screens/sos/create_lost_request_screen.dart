import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../models/dog.dart';
import '../../services/dog_service.dart';
import '../../services/request_service.dart';
import '../../services/storage_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/guest_access_screen.dart';

class CreateLostRequestScreen extends StatefulWidget {
  const CreateLostRequestScreen({super.key});

  @override
  State<CreateLostRequestScreen> createState() => _CreateLostRequestScreenState();
}

class _CreateLostRequestScreenState extends State<CreateLostRequestScreen> {
  List<Dog> dogs = [];
  Dog? selected;
  final location = TextEditingController();
  final description = TextEditingController();
  final reward = TextEditingController();
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

  Future<void> useLocation() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        throw Exception('Permiso de ubicación no concedido.');
      }
      final p = await Geolocator.getCurrentPosition();
      location.text = '${p.latitude}, ${p.longitude}';
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> pickPhotos() async {
    final result = await ImagePicker().pickMultiImage(imageQuality: 80);
    setState(() => photos.addAll(result.map((image) => File(image.path))));
  }

  Future<void> publish() async {
    if (selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registra una mascota primero.')));
      return;
    }
    setState(() => saving = true);
    try {
      final urls = <String>[];
      for (final f in photos) {
        urls.add(await StorageService().uploadImage(file: f, folder: 'requests'));
      }

      double? lat;
      double? lng;
      final parts = location.text.split(',');
      if (parts.length == 2) {
        lat = double.tryParse(parts[0].trim());
        lng = double.tryParse(parts[1].trim());
      }

      await RequestService().createRequest(
        dogId: selected!.id,
        type: 'lost',
        description: description.text,
        images: urls,
        location: location.text,
        latitude: lat,
        longitude: lng,
        reward: double.tryParse(reward.text) ?? 0,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Alerta publicada para la comunidad.')));
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
      appBar: AppBar(title: const Text('Mascota perdida')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownButtonFormField<Dog>(
            value: selected,
            decoration: const InputDecoration(labelText: '¿Qué mascota está perdida?'),
            items: dogs.map((dog) => DropdownMenuItem(value: dog, child: Text(dog.name))).toList(),
            onChanged: (v) => setState(() => selected = v),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: location,
            decoration: InputDecoration(
              labelText: 'Última ubicación conocida',
              prefixIcon: const Icon(Icons.location_on),
              suffixIcon: IconButton(onPressed: useLocation, icon: const Icon(Icons.my_location)),
            ),
          ),
          const SizedBox(height: 14),
          TextField(controller: description, maxLines: 4, decoration: const InputDecoration(labelText: 'Descripción')),
          const SizedBox(height: 14),
          TextField(controller: reward, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Recompensa ofrecida', prefixText: '\$ ')),
          const SizedBox(height: 14),
          OutlinedButton.icon(onPressed: pickPhotos, icon: const Icon(Icons.photo_library), label: Text('Agregar fotos (${photos.length})')),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: saving ? null : publish,
            icon: const Icon(Icons.campaign),
            label: Text(saving ? 'Publicando...' : 'PUBLICAR ALERTA'),
          ),
        ],
      ),
    );
  }
}
