import 'package:flutter/material.dart';
import '../../models/request_model.dart';
import '../../services/request_service.dart';
import 'chat_screen.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  List<PetRequest> requests = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      requests = await RequestService().getMyRequests();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mensajes')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : requests.isEmpty
              ? const Center(child: Text('No tienes conversaciones todavía.'))
              : ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (_, i) {
                    final r = requests[i];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(r.isLost ? Icons.search : Icons.medical_services),
                      ),
                      title: Text(r.dog?.name ?? 'Mascota'),
                      subtitle: Text(r.isLost ? 'Perro perdido' : 'Atención veterinaria'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ChatScreen(request: r)),
                      ),
                    );
                  },
                ),
    );
  }
}
