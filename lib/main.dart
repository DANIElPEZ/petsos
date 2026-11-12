import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/supabase_config.dart';
import 'screens/home/home_screen.dart';
import 'services/offline_sos_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  // La cola se sincroniza al iniciar y cada vez que el dispositivo recupera red.
  await OfflineSosService.instance.initialize();

  runApp(const PetsOSApp());
}

class PetsOSApp extends StatelessWidget {
  const PetsOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetsOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF7F8F5),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      // El usuario puede explorar como invitado; autenticación se solicita
      // únicamente al intentar usar funciones que guardan información personal.
      home: const HomeScreen(),
    );
  }
}
