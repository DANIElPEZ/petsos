**PETSOS**
***
**OBJETIVO DEL PRODUCTO:**

Al finalizar el Sprint 1 el proyecto del curso Desarrollo de Aplicaciones Móviles (Ingeniería Informática, 8 semestre, UNIPAZ), 
PetsOS tendrá definidos y documentados los flujos principales de emergencia, historias de usuario con criterios de aceptación 
comprobables y una primera versión de la lista y el detalle de perros perdidos que funcione en un dispositivo Android.
Este objetivo permite verificar al final del sprint si se cumplió, sin exigir que toda la aplicación esté terminada.
***

**TABLA DE TAREAS:**
| Actividad | Responsable | Entregable | Estado |
|---|---|---|---|
| Definir historias prioritarias | Product Owner | Backlog actualizado | Pendiente |
| Crear persona y mapa de experiencia | Product Owner | `docs/requisitos.md` | Pendiente |
| Escribir criterios de aceptación | Equipo de desarrollo | Archivos `.feature` | Pendiente |
| Definir MVP y requisitos de calidad | Product Owner y Scrum Master | Mapa de historias y requisitos | Pendiente |
| Entrevistar usuarios | Scrum Master | Fichas de entrevistas | Pendiente |
| Construir lista y detalle de perros perdidos | Equipo de desarrollo | Pantallas funcionales | Pendiente |
| Ejecutar pruebas y revisar código | Equipo de desarrollo | Pruebas y Pull Request | Pendiente |
| Realizar demostración y retrospectiva | Equipo de desarrollo | `docs/sprints/sprint-1.md` | Pendiente |
***
**MVP - Mapa de Historia**
| Etapa | Funcionalidades incluidas | Prioridad |
|---|---|---|
| Acceso | Registro, login y selección de rol | Alta |
| Mascotas | Registrar y consultar perros | Alta |
| Emergencias | Botón SOS y creación de solicitudes | Alta |
| Perros perdidos | Publicar, listar y consultar alertas | Alta |
| Recuperación | Reportar encontrado y contactar al propietario | Alta |
| Atención médica | Crear solicitud, consultar y aceptar | Alta |
| Comunicación | Chat entre los participantes de una solicitud | Alta |
| Funciones futuras | GPS en tiempo real, pagos y agenda de citas | Fuera del MVP |
***
**Calculo porcentaje**
| Concepto | Valor |
|---|---:|
| Puntos de las historias incluidas en el MVP | Pendiente |
| Puntos totales del backlog | 79 SP (estimación inicial) |
| Porcentaje del MVP | Pendiente de calcular |
| Límite propuesto por la guía

***
**Poner números a la calidad**
Los requisitos de calidad deben ser medibles, no simplemente decir que PetsOS será rápida, segura o fácil de usar.
| ID | Requisito | Método de verificación |
|---|---|---|
| RC-01 | La lista debe cargar en un máximo de 2 segundos bajo condiciones de prueba definidas. | Medir el tiempo de carga con 200 solicitudes y conexión estable. |
| RC-02 | No debe existir desplazamiento horizontal involuntario en pantallas de 360 dp. | Probar la lista y el detalle en un dispositivo o emulador. |
| RC-03 | Los formularios deben identificar los campos obligatorios incompletos. | Probar formularios vacíos y datos incompletos. |
| RC-04 | La lista debe contemplar estados de carga, vacío, error y datos. | Ejecutar pruebas para los cuatro estados. |
| RC-05 | Las pruebas automatizadas deben finalizar sin fallos antes de entregar el sprint. | Ejecutar `flutter test`. |
***

| Heurística | Aplicación en PetsOS |
|---|---|
| Visibilidad del estado | Mostrar si una solicitud está cargando, publicada o falló. |
| Correspondencia con el mundo real | Utilizar términos como «Perro perdido» y «Perro enfermo». |
| Control y libertad | Permitir regresar sin publicar accidentalmente. |
| Consistencia | Mantener los mismos estilos y componentes. |
| Prevención de errores | Validar campos obligatorios y recompensa. |
| Reconocimiento antes que recuerdo | Mostrar fotografías y datos del perro seleccionado. |
| Flexibilidad y eficiencia | Facilitar la consulta de alertas. |
| Diseño minimalista | Priorizar la información importante de la emergencia. |
| Recuperación de errores | Ofrecer una opción para reintentar. |
| Ayuda y documentación | Explicar cómo publicar alertas y contactar al propietario. |
