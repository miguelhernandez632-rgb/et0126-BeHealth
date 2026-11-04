# BeHealthy - App de Seguimiento de Hábitos Saludables

Mi app se llama BeHealthy. Está dirigida a Personas con poco tiempo, quienes necesitan mantener una rutina constante de hábitos saludables (agua, ejercicio, estudio y descanso) a pesar de sus horarios pesados. La app le ayudará a organizar y registrar sus hábitos diarios mediante una interfaz sencilla, un tablero de progreso visual y notificaciones de control.

## 1. Nombre de la app
BeHealthy

## 2. Usuario
Personas que buscan equilibrar su rendimiento académico con su bienestar físico y mental.

## 3. Problema
Falta de tiempo y constancia para registrar hábitos diarios de bienestar, lo que lleva al sedentarismo, mala hidratación y desorganización personal.

## 4. Solución
Una aplicación móvil rápida e intuitiva que permite registrar hábitos diarios, consultar el historial acumulado y visualizar el progreso de cumplimiento mediante un indicador gráfico en Canvas.

## 5. Funciones iniciales
1. Registrar un nuevo hábito completado (ej. Beber agua, Estudiar, Caminar 30 min).
2. Consultar la lista de hábitos diarios con sus respectivas categorías y estados.
3. Visualizar el nivel de cumplimiento global mediante una barra de progreso circular personalizada con Canvas.

## 6. Recorrido principal
1. Al abrir la app, se muestra la pantalla de bienvenida con el logotipo institucional o de la app y un resumen del día.
2. El usuario presiona el botón para agregar un hábito o marcar uno existente.
3. Se abre un formulario flotante donde ingresa el nombre del hábito y selecciona una categoría (Set de etiquetas).
4. La app valida que el texto no esté vacío y guarda el registro localmente.
5. El registro aparece en la lista principal y el Canvas se actualiza reflejando el porcentaje de avance.

## 7. Datos
- **Registros de hábitos:** Lista de objetos con título, categoría, fecha y estado de completado.
- **Preferencias de usuario:** Nombre del usuario y racha actual almacenados usando `SharedPreferences`.

## 8. Canvas
Un componente gráfico personalizado (`CustomPainter`) que dibuja un anillo de progreso circular interactivo que se llena dinámicamente según el porcentaje de hábitos completados en el día.

## 9. Almacenamiento Local
Se eligió **SharedPreferences** porque permite guardar de forma ligera y rápida las preferencias del usuario y una lista serializada en formato JSON de los hábitos diarios, sin la complejidad de una base de datos relacional en esta primera versión.

## 10. Conceptos de Dart en mi app
- **Tipos, final, const y null safety:** Utilizados en todo el modelo `Habit` para asegurar que campos críticos como el título no sean nulos (`String`).
- **Clases y objetos:** Definición del modelo `Habit` en `lib/models/habit.dart`.
- **Funciones:** Validaciones de entrada de texto separadas en funciones puras.
- **List:** Colección principal `List<Habit>` para almacenar los registros en memoria.
- **Set:** Uso de un `Set<String>` para gestionar las categorías únicas de los hábitos sin duplicados.
- **Map:** Uso de un `Map<String, int>` para agrupar y resumir los hábitos completados por categoría.
- **if y for:** Utilizados para filtrar los hábitos pendientes y renderizarlos dinámicamente en la interfaz con widgets.
- **while:** *Justificación:* No se utilizó un bucle `while` en este recorrido funcional ya que la interacción se basa en eventos asíncronos de la interfaz y flujos basados en listas (`for`/`map`), donde los bucles condicionales de reintento no aplican.

## 11. Declaración de uso de IA
Para la elaboración de la estructura inicial del proyecto, la guía de implementación de los widgets y la lógica de persistencia con `SharedPreferences` se utilizó asistencia de inteligencia artificial bajo la supervisión directa del autor, quien comprende, edita y puede explicar cada línea de código entregada.

## 12. Instrucciones de Ejecución
1. Clona el repositorio: `git clone https://github.com/tu-usuario/et0126-behealthy.git`
2. Instala las dependencias: `flutter pub get`
3. Ejecuta la aplicación: `flutter run`