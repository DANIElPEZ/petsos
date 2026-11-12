import 'package:flutter/material.dart';
import '../../models/request_model.dart';
import '../../services/request_service.dart';
import '../../widgets/lost_request_card.dart';
import 'lost_dog_detail_screen.dart';

class LostDogsScreen extends StatefulWidget {
  const LostDogsScreen({super.key});

  @override
  State<LostDogsScreen> createState() => _LostDogsScreenState();
}

class _LostDogsScreenState extends State<LostDogsScreen> {
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
      requests = await RequestService().getLostRequests();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perros perdidos')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : requests.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text('No hay alertas de perros perdidos activas.', textAlign: TextAlign.center),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: load,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: requests.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => LostRequestCard(
                      request: requests[i],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LostDogDetailScreen(request: requests[i])),
                      ).then((_) => load()),
                    ),
                  ),
                ),
    );
  }
}
