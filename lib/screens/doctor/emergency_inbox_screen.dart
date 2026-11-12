import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmergencyInboxScreen extends StatefulWidget {
  const EmergencyInboxScreen({super.key});

  @override
  State<EmergencyInboxScreen> createState() => _EmergencyInboxScreenState();
}

class _EmergencyInboxScreenState extends State<EmergencyInboxScreen> {
  List<Map<String, dynamic>> events = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() => loading = true);
    try {
      final data = await Supabase.instance.client
          .from('emergency_events')
          .select()
          .order('created_at', ascending: false);
      events = (data as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudieron cargar las alertas: $error')),
        );
      }
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alertas SOS recibidas'),
        actions: [IconButton(onPressed: load, icon: const Icon(Icons.refresh))],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : events.isEmpty
              ? const Center(child: Text('No hay alertas SOS registradas.'))
              : RefreshIndicator(
                  onRefresh: load,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: events.length,
                    itemBuilder: (_, index) {
                      final event = events[index];
                      final isLost = event['emergency_type'] == 'lost';
                      return Card(
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            child: Icon(isLost ? Icons.search : Icons.local_hospital),
                          ),
                          title: Text('${event['pet_name'] ?? 'Mascota'} · ${event['pet_type'] ?? 'Mascota'}'),
                          subtitle: Text(isLost ? 'Mascota perdida' : 'Urgencia veterinaria'),
                          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(event['description']?.toString() ?? 'Sin descripción'),
                            ),
                            if ((event['location'] as String?)?.isNotEmpty == true)
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.location_on_outlined),
                                title: Text(event['location'].toString()),
                              ),
                            if ((event['contact_phone'] as String?)?.isNotEmpty == true)
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.phone_outlined),
                                title: Text(event['contact_phone'].toString()),
                              ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Estado: ${event['status'] ?? 'received'}'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
