import 'package:flutter/material.dart';
import '../../models/request_model.dart';
import '../../services/request_service.dart';
import '../chat/chat_screen.dart';

class MedicalRequestDetailScreen extends StatefulWidget {
  final PetRequest request;

  const MedicalRequestDetailScreen({super.key, required this.request});

  @override
  State<MedicalRequestDetailScreen> createState() => _MedicalRequestDetailScreenState();
}

class _MedicalRequestDetailScreenState extends State<MedicalRequestDetailScreen> {
  bool loading = false;

  Future<void> accept() async {
    setState(() => loading = true);
    try {
      await RequestService().acceptMedicalRequest(widget.request.id);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ChatScreen(request: widget.request)),
      );
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.request;
    final dog = r.dog;

    return Scaffold(
      appBar: AppBar(title: const Text('Solicitud médica')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(dog?.name ?? 'Mascota', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (dog?.breed != null) Text('Raza: ${dog!.breed}'),
          const SizedBox(height: 20),
          const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          Text(r.description ?? 'Sin descripción'),
          const SizedBox(height: 20),
          if (r.location != null) Text('📍 ${r.location}'),
          const SizedBox(height: 25),
          FilledButton.icon(
            onPressed: loading ? null : accept,
            icon: const Icon(Icons.check),
            label: Text(loading ? 'Aceptando...' : 'ACEPTAR ATENCIÓN'),
          ),
        ],
      ),
    );
  }
}
