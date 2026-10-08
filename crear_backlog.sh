#!/bin/bash

gh issue create \
  --title "HU-01: Registro de usuario" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero registrarme en PetsOS para poder utilizar la aplicación.

## Criterios de aceptación
- [ ] El usuario puede registrarse con nombre, correo y contraseña.
- [ ] El sistema debe crear la cuenta correctamente.
- [ ] El usuario puede iniciar sesión después del registro.

## Prioridad
Must

## Notas técnicas
Utilizar Supabase Auth y la tabla profiles."

gh issue create \
  --title "HU-02: Inicio de sesión" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero iniciar sesión para acceder a mi cuenta.

## Criterios de aceptación
- [ ] El usuario puede ingresar correo y contraseña.
- [ ] Las credenciales correctas permiten acceder.
- [ ] Las credenciales incorrectas muestran un error.
- [ ] El usuario accede al Home correspondiente a su rol.

## Prioridad
Must

## Notas técnicas
Utilizar Supabase Auth."

gh issue create \
  --title "HU-03: Selección de rol" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero seleccionar si soy usuario normal o médico durante el registro.

## Criterios de aceptación
- [ ] Se puede seleccionar usuario normal.
- [ ] Se puede seleccionar médico.
- [ ] El rol queda almacenado correctamente.
- [ ] El Home depende del rol.

## Prioridad
Must

## Notas técnicas
Tabla profiles. Roles: user y doctor."

gh issue create \
  --title "HU-04: Registrar perros" \
  --label "historia" \
  --body "## Historia
Como usuario normal, quiero registrar mis perros para tenerlos disponibles en la aplicación.

## Criterios de aceptación
- [ ] Se puede registrar nombre.
- [ ] Se puede registrar raza.
- [ ] Se puede registrar sexo.
- [ ] Se puede registrar edad.
- [ ] Se puede registrar color.
- [ ] Se puede agregar descripción.
- [ ] Se pueden agregar fotografías.

## Prioridad
Must

## Notas técnicas
Tabla dogs. Fotografías mediante Supabase Storage."

gh issue create \
  --title "HU-05: Consultar perros registrados" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero consultar mis perros registrados.

## Criterios de aceptación
- [ ] Se muestra una lista de perros.
- [ ] Solo aparecen los perros asociados al usuario.
- [ ] Se puede acceder al detalle de cada perro.

## Prioridad
Must

## Notas técnicas
Consultar tabla dogs filtrando por owner_id."

gh issue create \
  --title "HU-06: Editar información del perro" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero editar la información de mi perro.

## Criterios de aceptación
- [ ] Se pueden modificar los datos.
- [ ] Se pueden actualizar las fotografías.
- [ ] Los cambios se guardan correctamente.

## Prioridad
Should

## Notas técnicas
Actualizar registro correspondiente en dogs."

gh issue create \
  --title "HU-07: Eliminar perro" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero eliminar un perro registrado.

## Criterios de aceptación
- [ ] El usuario puede seleccionar eliminar.
- [ ] Se solicita confirmación.
- [ ] El perro deja de aparecer en su lista.

## Prioridad
Should

## Notas técnicas
Eliminar registro de dogs."

gh issue create \
  --title "HU-08: Botón SOS" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero acceder a un botón SOS para informar una emergencia.

## Criterios de aceptación
- [ ] Existe un botón SOS.
- [ ] Permite seleccionar Perro perdido.
- [ ] Permite seleccionar Perro enfermo.

## Prioridad
Must

## Notas técnicas
Crear SosScreen."

gh issue create \
  --title "HU-09: Reportar perro perdido" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero reportar que mi perro está perdido.

## Criterios de aceptación
- [ ] Se puede seleccionar el perro.
- [ ] Se puede agregar descripción.
- [ ] Se puede indicar ubicación.
- [ ] Se pueden agregar fotografías.
- [ ] Se puede establecer recompensa.
- [ ] Se crea una solicitud de tipo lost.

## Prioridad
Must

## Notas técnicas
Tabla requests."

gh issue create \
  --title "HU-10: Publicar alerta de perro perdido" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero publicar la alerta de mi perro perdido para que la comunidad pueda verla.

## Criterios de aceptación
- [ ] La alerta queda almacenada.
- [ ] La alerta aparece en la lista de perros perdidos.
- [ ] La alerta permanece activa hasta que sea encontrada.

## Prioridad
Must

## Notas técnicas
requests.type = lost y status = active."

gh issue create \
  --title "HU-11: Consultar perros perdidos" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero consultar los perros perdidos de la comunidad.

## Criterios de aceptación
- [ ] Se muestran las alertas activas.
- [ ] Se muestra información relevante.
- [ ] Se muestran fotografías.

## Prioridad
Must

## Notas técnicas
Consultar requests con type lost y status active."

gh issue create \
  --title "HU-12: Detalle de perro perdido" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero consultar el detalle de un perro perdido.

## Criterios de aceptación
- [ ] Se muestran fotografías.
- [ ] Se muestran características.
- [ ] Se muestra ubicación conocida.
- [ ] Se muestra descripción.
- [ ] Se muestra recompensa.

## Prioridad
Must"

gh issue create \
  --title "HU-13: Reportar perro encontrado" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero informar que encontré un perro perdido.

## Criterios de aceptación
- [ ] Se puede indicar que el perro fue encontrado.
- [ ] El usuario queda identificado como finder.
- [ ] Se puede iniciar comunicación con el propietario.

## Prioridad
Must

## Notas técnicas
Utilizar finder_id en requests."

gh issue create \
  --title "HU-14: Comunicación con persona que encontró el perro" \
  --label "historia" \
  --body "## Historia
Como propietario, quiero comunicarme con la persona que encontró mi perro.

## Criterios de aceptación
- [ ] Existe un chat asociado a la solicitud.
- [ ] El propietario puede enviar mensajes.
- [ ] La persona que encontró el perro puede responder.

## Prioridad
Must

## Notas técnicas
Utilizar tabla messages."

gh issue create \
  --title "HU-15: Enviar fotografías por el chat" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero enviar fotografías por el chat.

## Criterios de aceptación
- [ ] Se puede seleccionar una fotografía.
- [ ] Se puede subir a Supabase Storage.
- [ ] Se guarda la URL en el mensaje.
- [ ] La fotografía aparece en la conversación.

## Prioridad
Should

## Notas técnicas
Campo images de messages."

gh issue create \
  --title "HU-16: Marcar perro como encontrado" \
  --label "historia" \
  --body "## Historia
Como propietario, quiero marcar mi perro como encontrado después de recuperarlo.

## Criterios de aceptación
- [ ] El propietario puede finalizar la alerta.
- [ ] El estado cambia a found.
- [ ] Deja de aparecer entre las alertas activas.

## Prioridad
Must

## Notas técnicas
Actualizar requests.status."

gh issue create \
  --title "HU-17: Reportar perro enfermo" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero reportar que mi perro está enfermo.

## Criterios de aceptación
- [ ] Se puede seleccionar el perro.
- [ ] Se puede describir la situación.
- [ ] Se pueden adjuntar fotografías.
- [ ] Se crea una solicitud medical.

## Prioridad
Must

## Notas técnicas
Tabla requests con type = medical."

gh issue create \
  --title "HU-18: Consultar solicitudes médicas" \
  --label "historia" \
  --body "## Historia
Como médico, quiero consultar las solicitudes de perros enfermos.

## Criterios de aceptación
- [ ] Los médicos pueden consultar solicitudes activas.
- [ ] Se muestra información del perro.
- [ ] Se muestra la descripción de la situación.

## Prioridad
Must

## Notas técnicas
Filtrar requests por type = medical."

gh issue create \
  --title "HU-19: Aceptar solicitud médica" \
  --label "historia" \
  --body "## Historia
Como médico, quiero aceptar una solicitud médica.

## Criterios de aceptación
- [ ] El médico puede aceptar la solicitud.
- [ ] La solicitud queda asociada al médico.
- [ ] El estado cambia a accepted.

## Prioridad
Must

## Notas técnicas
Actualizar doctor_id y status en requests."

gh issue create \
  --title "HU-20: Comunicación con médico" \
  --label "historia" \
  --body "## Historia
Como propietario, quiero comunicarme con el médico que atiende mi solicitud.

## Criterios de aceptación
- [ ] Se crea o habilita una conversación.
- [ ] El propietario puede enviar mensajes.
- [ ] El médico puede responder.

## Prioridad
Must

## Notas técnicas
Utilizar messages."

gh issue create \
  --title "HU-21: Finalizar atención médica" \
  --label "historia" \
  --body "## Historia
Como médico, quiero finalizar una atención.

## Criterios de aceptación
- [ ] El médico puede finalizar la solicitud.
- [ ] El estado cambia a completed.
- [ ] Deja de aparecer como pendiente.

## Prioridad
Should

## Notas técnicas
Actualizar requests.status."

gh issue create \
  --title "HU-22: Consultar conversaciones" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero consultar mis conversaciones.

## Criterios de aceptación
- [ ] Se muestra una lista de conversaciones.
- [ ] Se muestran las solicitudes relacionadas.
- [ ] El usuario puede abrir una conversación.

## Prioridad
Should

## Notas técnicas
Utilizar requests y messages."

gh issue create \
  --title "HU-23: Consultar y modificar perfil" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero consultar y modificar mi perfil.

## Criterios de aceptación
- [ ] Se muestran los datos del usuario.
- [ ] Se pueden modificar los datos permitidos.
- [ ] Los cambios se guardan en Supabase.

## Prioridad
Should

## Notas técnicas
Tabla profiles."

gh issue create \
  --title "HU-24: Información profesional del médico" \
  --label "historia" \
  --body "## Historia
Como médico, quiero mostrar mi información profesional.

## Criterios de aceptación
- [ ] Se muestra la especialidad.
- [ ] Se muestra la tarjeta profesional.
- [ ] La información pertenece al médico correspondiente.

## Prioridad
Should

## Notas técnicas
Campos specialty y professional_card de profiles."

gh issue create \
  --title "HU-25: Cerrar sesión" \
  --label "historia" \
  --body "## Historia
Como usuario, quiero cerrar sesión.

## Criterios de aceptación
- [ ] Existe una opción para cerrar sesión.
- [ ] Se elimina la sesión activa.
- [ ] El usuario vuelve al login.

## Prioridad
Must

## Notas técnicas
Utilizar Supabase Auth signOut."
