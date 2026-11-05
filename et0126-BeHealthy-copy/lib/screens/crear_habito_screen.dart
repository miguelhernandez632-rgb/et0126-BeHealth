import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';

class CrearHabitoScreen extends StatefulWidget {
  const CrearHabitoScreen({super.key});

  @override
  State<CrearHabitoScreen> createState() => _CrearHabitoScreenState();
}

class _CrearHabitoScreenState extends State<CrearHabitoScreen> {
  // 1. GlobalKey para controlar y validar el formulario
  final _formKey = GlobalKey<FormState>();

  // 2. Controladores de texto
  final _tituloController = TextEditingController();
  final _observacionController = TextEditingController();

  // 3. Variables de estado
  String _selectedCategory = 'Salud';
  final Set<String> _categories = {
    'Salud',
    'Estudio',
    'Productividad',
    'Ejercicio'
  };
  bool _isLoading = false;

  final HabitService _habitService = HabitService();

  @override
  void dispose() {
    _tituloController.dispose();
    _observacionController.dispose();
    super.dispose();
  }

  // Validador compuesto con MultiValidator
  final _tituloValidator = MultiValidator([
    RequiredValidator(errorText: 'Escribe un título para el hábito.'),
    MinLengthValidator(3, errorText: 'Usa al menos 3 caracteres.'),
  ]);

  Future<void> _guardarHabito() async {
    // 1. Ejecutar validación del formulario
    if (!_formKey.currentState!.validate()) {
      return; // Si es inválido, se detiene y no llama al servicio
    }

    // 2. Marcar pantalla como ocupada para evitar doble envío
    setState(() {
      _isLoading = true;
    });

    try {
      // Crear objeto del modelo
      final nuevoHabito = Habit(
        id: DateTime.now().toIso8601String(),
        title: _tituloController.text.trim(),
        category: _selectedCategory,
        isCompleted: false,
      );

      // 3. Esperar la respuesta del servicio asíncrono
      await _habitService.crear(nuevoHabito);

      // Verificar si el State sigue montado antes de usar el context
      if (!mounted) return;

      // 4. Éxito: Notificar y regresar a la pantalla anterior actualizando la lista
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Hábito registrado correctamente en el servicio!'),
          backgroundColor: Colors.teal,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      // 5. Manejo de errores de negocio (ej. duplicados)
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('StateError: ', '')),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      // 6. Terminar estado de carga de forma segura
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Nuevo Hábito'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Formulario de Registro de Actividad',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Campo 1: Título con MultiValidator
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título del hábito',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: _tituloValidator,
              ),
              const SizedBox(height: 16),

              // Campo 2: Selector de Categoría (Dropdown)
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: _isLoading
                    ? null
                    : (val) {
                        if (val != null) {
                          setState(() => _selectedCategory = val);
                        }
                      },
              ),
              const SizedBox(height: 16),

              // Campo 3: Observación con validación de longitud mínima
              TextFormField(
                controller: _observacionController,
                decoration: const InputDecoration(
                  labelText: 'Observación / Meta diaria',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                validator: MinLengthValidator(5,
                        errorText:
                            'Escribe al menos 5 caracteres en la observación.')
                    .call,
              ),
              const SizedBox(height: 30),

              // Botón de guardar con protección contra doble envío y estado de carga
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _guardarHabito,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  _isLoading ? 'Guardando en el servicio...' : 'Guardar Hábito',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
