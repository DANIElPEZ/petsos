import 'package:flutter/material.dart';
import '../../models/profile.dart';
import '../../services/auth_service.dart';
import '../../services/profile_service.dart';
import '../home/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? profile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      profile = await ProfileService().getMyProfile();
    } catch (_) {}
    if (mounted) setState(() => loading = false);
  }

  Future<void> logout() async {
    await AuthService().signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 45)),
          const SizedBox(height: 15),
          Center(
            child: Text(
              profile?.fullName ?? '',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Center(child: Text(profile?.role == 'doctor' ? 'Veterinario' : 'Usuario')),
          const SizedBox(height: 25),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Teléfono'),
            subtitle: Text(profile?.phone ?? 'No registrado'),
          ),
          if (profile?.isDoctor == true) ...[
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('Tarjeta profesional'),
              subtitle: Text(profile?.professionalCard ?? 'No registrada'),
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Especialidad'),
              subtitle: Text(profile?.specialty ?? 'No registrada'),
            ),
          ],
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            onPressed: logout,
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
