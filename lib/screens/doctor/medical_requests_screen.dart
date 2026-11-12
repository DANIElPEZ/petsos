import 'package:flutter/material.dart';
import '../../models/request_model.dart';
import '../../services/request_service.dart';
import 'medical_request_detail_screen.dart';

class MedicalRequestsScreen extends StatefulWidget {
  const MedicalRequestsScreen({super.key});

  @override
  State<MedicalRequestsScreen> createState() => _MedicalRequestsScreenState();
}

class _MedicalRequestsScreenState extends State<MedicalRequestsScreen> {
  List<PetRequest> requests = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() => loading = true);
    try {
      requests = await RequestService().getMedicalRequests();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitudes médicas')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : requests.isEmpty
              ? const Center(child: Text('No hay solicitudes médicas pendientes.'))
              : RefreshIndicator(
                  onRefresh: load,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: requests.length,
                    itemBuilder: (_, i) {
                      final r = requests[i];
                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.local_hospital)),
                          title: Text(r.dog?.name ?? 'Mascota'),
                          subtitle: Text(r.description ?? 'Sin descripción'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MedicalRequestDetailScreen(request: r)),
                          ).then((_) => load()),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
