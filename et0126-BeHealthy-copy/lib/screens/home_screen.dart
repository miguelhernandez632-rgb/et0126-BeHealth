import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';
import '../widgets/habit_canvas_progress.dart';
import 'crear_habito_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HabitService _habitService = HabitService();
  List<Habit> _habits = [];
  bool _isLoading = true;

  final TextEditingController _controller = TextEditingController();

  final Set<String> _categories = {'Salud', 'Estudio', 'Productividad'};
  String _selectedCategory = 'Salud';

  @override
  void initState() {
    super.initState();
    _cargarHabitos();
  }

  // Cargar hábitos de forma asíncrona desde el servicio
  Future<void> _cargarHabitos() async {
    setState(() => _isLoading = true);
    try {
      final habitosCargados = await _habitService.listar();
      if (mounted) {
        setState(() {
          _habits = habitosCargados;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _toggleHabit(int index) {
    setState(() {
      _habits[index].isCompleted = !_habits[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Cálculo del progreso usando Map y operaciones de filtrado
    int completedCount = _habits.where((h) => h.isCompleted).length;
    double progress = _habits.isEmpty ? 0.0 : completedCount / _habits.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BeHealthy - Hábitos'),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 16),
                const Icon(
                  Icons.favorite,
                  size: 60,
                  color: Colors.teal,
                ),
                const SizedBox(height: 12),
                // Canvas integrado
                HabitCanvasProgress(progress: progress),
                const SizedBox(height: 12),
                Text(
                  'Completados: $completedCount de ${_habits.length}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Divider(height: 32, thickness: 1),
                Expanded(
                  child: _habits.isEmpty
                      ? const Center(
                          child: Text(
                            'No hay hábitos registrados.\n¡Agrega uno nuevo con el botón +!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _habits.length,
                          itemBuilder: (context, index) {
                            final habit = _habits[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: ListTile(
                                leading: Checkbox(
                                  value: habit.isCompleted,
                                  onChanged: (bool? value) =>
                                      _toggleHabit(index),
                                ),
                                title: Text(
                                  habit.title,
                                  style: TextStyle(
                                    decoration: habit.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                subtitle: Text('Categoría: ${habit.category}'),
                                trailing: Icon(
                                  habit.isCompleted
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: habit.isCompleted
                                      ? Colors.teal
                                      : Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navegar a la pantalla del formulario creado
          final seAgregoNuevo = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CrearHabitoScreen(),
            ),
          );

          // Si el formulario guardó con éxito, recargamos la lista desde el servicio
          if (seAgregoNuevo == true) {
            _cargarHabitos();
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
