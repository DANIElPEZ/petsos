import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/profile.dart';
import '../../services/profile_service.dart';
import '../../services/offline_sos_service.dart';
import '../../widgets/sos_button.dart';
import '../auth/guest_access_screen.dart';
import '../dogs/dogs_screen.dart';
import '../profile/profile_screen.dart';
import '../services/services_menu_screen.dart';
import '../sos/sos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int index = 0;
  Profile? profile;
  bool loading = false;

  bool get authenticated => Supabase.instance.client.auth.currentSession != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (authenticated) _loadProfile();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      OfflineSosService.instance.syncPending();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _loadProfile() async {
    setState(() => loading = true);
    try {
      profile = await ProfileService().getMyProfile();
    } catch (_) {
      // La navegación de inicio no depende de que el perfil esté disponible.
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDoctor = profile?.isDoctor ?? false;
    final isGuest = !authenticated;

    final pages = <Widget>[
      const _PanicHome(),
      isGuest
          ? const GuestAccessScreen(
              title: 'Mis mascotas',
              description: 'Registra y administra perros, gatos, hámsteres, conejos, aves y más. Crea tu cuenta para guardar sus datos y acceder a sus fichas.',
              icon: Icons.pets,
            )
          : isDoctor
              ? const GuestAccessScreen(
                  title: 'Mascotas',
                  description: 'Esta sección está pensada para los perfiles de propietarios. Como veterinario puedes revisar las solicitudes en Servicios.',
                  icon: Icons.pets,
                )
              : const DogsScreen(),
      ServicesMenuScreen(isGuest: isGuest, isDoctor: isDoctor),
      isGuest
          ? const GuestAccessScreen(
              title: 'Tu perfil PetsOS',
              description: 'Inicia sesión o crea una cuenta para consultar tus datos, mascotas, solicitudes y conversaciones.',
              icon: Icons.account_circle_outlined,
            )
          : const ProfileScreen(),
    ];

    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.warning_amber_outlined),
            selectedIcon: Icon(Icons.warning_amber),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.pets_outlined),
            selectedIcon: Icon(Icons.pets),
            label: 'Mascotas',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            selectedIcon: Icon(Icons.medical_services),
            label: 'Servicios',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

/// La vista principal se mantiene deliberadamente reducida al botón de pánico.
class _PanicHome extends StatelessWidget {
  const _PanicHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PetsOS'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SosButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SosScreen()),
            ),
          ),
        ),
      ),
    );
  }
}
