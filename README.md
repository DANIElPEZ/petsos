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

***

| Reconocimiento antes que recuerdo | Mostrar fotografías y datos del perro seleccionado. |
| Flexibilidad y eficiencia | Facilitar la consulta de alertas. |
| Diseño minimalista | Priorizar la información importante de la emergencia. |
| Recuperación de errores | Ofrecer una opción para reintentar. |
| Ayuda y documentación | Explicar cómo publicar alertas y contactar al propietario. |

**Ficha de entrevista 1 — Jose Torres**

Fecha:	15/10/2026

Entrevistado: Jose Torres

Perfil:	Dueño de un perro

***
PETSOS-01 — Validar reporte de perros perdidos
**Preguntas y respuestas**

**1. ¿Tienes o has tenido perros?**
Sí, tengo un perro y lo considero parte de mi familia.

**2. ¿Qué situaciones difíciles o de emergencia has vivido con tu mascota?**
He tenido momentos en los que se ha enfermado y me he preocupado por no saber qué hacer inmediatamente.

**3. ¿Qué harías si tu perro se perdiera hoy?**
Publicaría fotografías en redes sociales y preguntaría a mis vecinos si lo han visto.

**4. ¿Cómo avisarías a otras personas para que te ayudaran a encontrarlo?**
Compartiría una publicación con su foto, sus características y el lugar donde lo vi por última vez.

**5. ¿Qué información consideras importante publicar para identificar a tu perro?**
Fotografías recientes, nombre, tamaño, color, características especiales y última ubicación conocida.

**6. ¿Te sería útil que la comunidad pudiera comunicarse contigo mediante mensajes y fotografías?**
Sí, porque podría comprobar si encontraron a mi perro y comunicarme directamente con la persona.

**7. ¿Considerarías ofrecer una recompensa por encontrar a tu mascota?**
Sí, si tuviera la posibilidad económica de hacerlo.

**8. ¿Qué haces cuando notas que tu perro está enfermo y necesitas ayuda?**
Busco información y trato de comunicarme con una clínica veterinaria.

**9. ¿Qué dificultades encuentras para contactar a un veterinario o conseguir orientación?**
En ocasiones no sé a quién contactar rápidamente y me preocupa recibir información equivocada.

**10. ¿Te sería útil una opción para publicar una solicitud de ayuda y contactar a una persona con perfil médico?**
Sí, siempre que pueda identificar a la persona que responde y saber qué tipo de ayuda puede ofrecer.

**11. ¿Qué tan fácil esperarías que fuera publicar una emergencia desde el celular?**
Debería ser muy fácil, con pocos pasos y opciones claras.

**12. ¿Qué información debería solicitar la aplicación para no hacerte perder tiempo?**
Los datos básicos del perro, fotografías, descripción del problema y ubicación cuando sea relevante.

**13. ¿Qué función te parece más importante: reportar perros perdidos, solicitar ayuda por enfermedad o ambas?**
Ambas, porque las dos situaciones pueden ser urgentes.

**14. ¿Qué te preocuparía al usar una aplicación de este tipo?**
Que mis datos personales queden expuestos o que otras personas publiquen información falsa.

**Conclusión**
El entrevistado considera útil contar con una herramienta para reportar perros perdidos y comunicarse con la comunidad. Se recomienda priorizar las fotografías, la descripción del perro, la última ubicación conocida y los mensajes.

***

**Ficha de entrevista 2 — Juan Kaimen**

Fecha:	15/10/2026

Entrevistado:	Juan Kaimen

Perfil:	Persona que convive con un perro
***
PETSOS-02 — Validar solicitud de ayuda por enfermedad

**Preguntas y respuestas**

**1. ¿Tienes o has tenido perros?**
Sí, tengo un perro y me preocupo por su bienestar.

**2. ¿Qué situaciones difíciles o de emergencia has vivido con tu mascota?**
He tenido situaciones en las que mi perro ha presentado síntomas de enfermedad y he necesitado orientación.

**3. ¿Qué harías si tu perro se perdiera hoy?**
Buscaría por los alrededores y publicaría información en redes sociales.

**4. ¿Cómo avisarías a otras personas para que te ayudaran a encontrarlo?**
Compartiría una fotografía y pediría a mis vecinos que estuvieran atentos.

**5. ¿Qué información consideras importante publicar para identificar a tu perro?**
Fotos claras, tamaño, color, nombre, características particulares y el lugar donde se perdió.

**6. ¿Te sería útil que la comunidad pudiera comunicarse contigo mediante mensajes y fotografías?**
Sí, porque facilitaría confirmar si alguien encontró a mi perro.

**7. ¿Considerarías ofrecer una recompensa por encontrar a tu mascota?**
Sí, dependiendo de mi situación económica.

**8. ¿Qué haces cuando notas que tu perro está enfermo y necesitas ayuda?**
Busco información y contacto a una clínica veterinaria para consultar qué debo hacer.

**9. ¿Qué dificultades encuentras para contactar a un veterinario o conseguir orientación?**
A veces es difícil encontrar atención rápidamente y no siempre sé qué información debo proporcionar.

**10. ¿Te sería útil una opción para publicar una solicitud de ayuda y contactar a una persona con perfil médico?**
Sí, porque podría describir lo que sucede y recibir una respuesta de una persona identificada.

**11. ¿Qué tan fácil esperarías que fuera publicar una emergencia desde el celular?**
Debería poder hacerse en pocos minutos, con un formulario sencillo.

**12. ¿Qué información debería solicitar la aplicación para no hacerte perder tiempo?**
Los datos de mi perro, los síntomas que presenta y fotografías opcionales.

**13. ¿Qué función te parece más importante: reportar perros perdidos, solicitar ayuda por enfermedad o ambas?**
Ambas funciones son importantes porque responden a necesidades diferentes.

**14. ¿Qué te preocuparía al usar una aplicación de este tipo?**
Me preocuparía recibir información incorrecta o no saber si la persona que responde es confiable.
***

**Conclusión**

El entrevistado considera valiosas las dos funciones de PetsOS y destaca la necesidad de facilitar el contacto y generar confianza. Se recomienda simplificar el formulario de emergencia y mostrar claramente el perfil de quien responde.
