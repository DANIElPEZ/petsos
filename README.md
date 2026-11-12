# PetsOS v3 — Flutter + Supabase con SOS offline

## Novedades v3
- 4 menús: SOS, Mascotas, Comunidad y Perfil.
- Inicio conserva el botón de pánico como acción principal.
- Registro de mascotas con 10 especies/categorías.
- Feedback y base Supabase del proyecto (ver SQL v2 y migración v3).
- **SOS offline:** los reportes se guardan en `SharedPreferences` (persisten al cerrar la app); al recuperar internet se sincronizan automáticamente si hay sesión iniciada. Si el usuario es invitado, permanecen localmente hasta iniciar sesión y se reintenta.
- Indicador de conexión y cantidad de SOS pendientes, botón de sincronización manual.
- Identificador `offline_client_id` con índice único para evitar duplicados.

## Configuración
1. Instala Flutter SDK y ejecuta `flutter pub get`.
2. Inicializa Supabase y ejecuta `supabase/petsos_v2.sql`.
3. Ejecuta `supabase/migration_v3_offline.sql`.
4. Lanza: `flutter run --dart-define=SUPABASE_URL=https://TU_PROYECTO.supabase.co --dart-define=SUPABASE_ANON_KEY=TU_ANON_KEY`.

## Limitación de SOS offline
Sin internet no es posible notificar a la comunidad ni a médicos en tiempo real. El teléfono guarda el reporte localmente y lo transmite cuando vuelve la conexión y existe una sesión autenticada. No sustituye llamar a los servicios de emergencia o acudir a atención veterinaria urgente.

## Importante
Este proyecto es una base funcional de desarrollo; antes de producción deben completarse pruebas en dispositivos, chat, almacenamiento de fotos, gestión de aceptación médica y validación de permisos/RLS.
