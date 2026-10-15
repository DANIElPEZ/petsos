**HU-01. Registro de usuario**
***
Como persona que desea utilizar PetsOS, quiero registrarme con mis datos personales y correo electrónico,
para crear una cuenta y acceder a las funcionalidades de la aplicación.
***
**Criterios de aceptación**
- El sistema debe solicitar nombre, correo electrónico y contraseña.
- Todos los campos obligatorios deben estar completos.
- El correo debe tener un formato válido.
- La contraseña debe cumplir los requisitos mínimos de seguridad definidos por la aplicación.
- Si el registro es exitoso, el usuario debe recibir una confirmación y poder continuar al inicio de sesión.
- Si ocurre un error, el sistema debe mostrar un mensaje claro. 

**Escenarios de prueba**
Escenario	Pasos	Resultado esperado
Éxito	1. Abrir la pantalla de registro. 2. Ingresar nombre, correo válido y contraseña válida. 3. Pulsar «Registrarse».	La cuenta se crea correctamente y se muestra un mensaje de confirmación.
Error	1. Abrir el registro. 2. Ingresar un correo con formato incorrecto o dejar un campo obligatorio vacío. 3. Pulsar «Registrarse».	El sistema indica qué dato debe corregirse y no permite completar el registro con información inválida.
Celular	1. Abrir el registro desde un celular. 2. Completar los campos usando el teclado del dispositivo. 3. Pulsar «Registrarse».	Los campos y el botón se visualizan correctamente, el teclado no oculta los controles importantes y el formulario puede utilizarse sin desbordamientos de pantalla.
***
**Revisó 2:** Andres Pineda
