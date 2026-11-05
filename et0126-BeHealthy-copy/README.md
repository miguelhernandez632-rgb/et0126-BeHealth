# BeHealthy - Taller de Continuación (ET0126)

## Propósito del Flujo
Este flujo implementa un formulario robusto de registro de hábitos conectado a un servicio asíncrono en memoria. Permite al usuario de la aplicación añadir nuevas actividades con validaciones de datos en tiempo real y reglas de negocio específicas del dominio, mejorando la interactividad de la aplicación.

## Arquitectura y Componentes
- **`models/habit.dart`**: Modelo de datos tipado para representar la estructura del hábito.
- **`services/habit_service.dart`**: Servicio asíncrono que simula una API mediante `Future.delayed`, `async`/`await`, y administra una lista inmutable en memoria con validación de duplicados.
- **`screens/crear_habito_screen.dart`**: Pantalla con `GlobalKey<FormState>`, validaciones avanzadas con `form_field_validator` (`MultiValidator`, `RequiredValidator`), y protección contra doble envío mediante indicadores de carga.
- **`screens/home_screen.dart`**: Pantalla principal que consume el servicio para listar los hábitos de forma reactiva y actualizar el progreso.

## Resultados de las Pruebas Manuales
| Caso Evaluado | Acción Realizada | Resultado Obtenido |
| :--- | :--- | :--- |
| **Campos vacíos** | Guardar sin rellenar el formulario. | Se activan los validadores y se bloquea el envío al servicio. |
| **Texto corto** | Escribir menos de 3 caracteres en el título. | El `MinLengthValidator` muestra la advertencia requerida. |
| **Registro válido** | Completar datos correctos y presionar guardar. | Muestra estado de carga, confirma con éxito y actualiza la lista. |
| **Error de negocio** | Intentar registrar un hábito con título duplicado. | El servicio rechaza la operación (`StateError`) y avisa al usuario. |
| **Envío rápido** | Clics múltiples y rápidos en el botón de guardar. | El botón se deshabilita durante la carga (`_isLoading`), evitando duplicados por pulsación. |

## Límite de la Simulación en Memoria
Los registros creados a través de este servicio residen temporalmente en la memoria RAM del proceso de ejecución. Al cerrar o reiniciar por completo la aplicación, los elementos añadidos en la simulación pueden reiniciarse, conservando la persistencia y la estructura base definida en las iteraciones anteriores.

## Declaración de Uso de IA
Para el desarrollo de este taller se empleó asistencia de inteligencia artificial como herramienta de apoyo para estructurar el manejo de estados asíncronos (`try/catch/finally`), aplicar el patrón de diseño por capas y resolver conflictos de compilación en el entorno en la nube (FlutLab). Todo el código fue revisado, probado e integrado manualmente.