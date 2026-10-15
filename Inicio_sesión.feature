**HU-02 · Inicio de sesión**
***
Como usuario registrado de PetsOS, quiero iniciar sesión con mi correo electrónico y contraseña,
para acceder a mi cuenta y utilizar las funcionalidades correspondientes a mi perfil.
***
**Criterios de aceptación**
- El sistema debe solicitar correo electrónico y contraseña.
- Los campos deben validarse antes de enviar la solicitud.
- Las credenciales correctas deben permitir el acceso.
- Si las credenciales son incorrectas, se debe mostrar un mensaje de error.
- Si el inicio de sesión es exitoso, el usuario debe acceder a la pantalla principal correspondiente a su perfil.
- Mientras se procesa el inicio de sesión, el sistema debe mostrar un indicador de carga y evitar envíos repetidos.
***
**Escenarios de prueba**
Escenario	Pasos	Resultado esperado
**Éxito**	1. Abrir la pantalla de inicio de sesión. 2. Ingresar un correo y una contraseña registrados. 3. Pulsar «Iniciar sesión». 	El sistema valida las credenciales y dirige al usuario a la pantalla principal de PetsOS.

**Error**	1. Abrir el inicio de sesión. 2. Ingresar una contraseña incorrecta o dejar campos vacíos. 3. Pulsar «Iniciar sesión».	 El sistema muestra un mensaje comprensible, no inicia la sesión y permite corregir los datos.

**Celular**	1. Abrir el inicio de sesión desde un celular. 2. Escribir las credenciales con el teclado virtual. 3. Pulsar «Iniciar sesión». 	La pantalla se adapta al tamaño del celular, los campos son fáciles de utilizar y el botón permanece accesible sin desbordamientos.

Revisó: Erick Vega - Equipo de desarrollo
