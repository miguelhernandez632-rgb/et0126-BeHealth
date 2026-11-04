import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../widgets/habit_canvas_progress.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista inicial de hábitos para que la app luzca viva desde el inicio
  final List<Habit> _habits = [
    Habit(
        id: '1',
        title: 'Beber 2L de agua',
        category: 'Salud',
        isCompleted: true),
    Habit(
        id: '2',
        title: 'Estudiar Flutter 30 min',
        category: 'Estudio',
        isCompleted: false),
  ];

  final TextEditingController _controller = TextEditingController();

  // Uso de Set para categorías únicas
  final Set<String> _categories = {'Salud', 'Estudio', 'Productividad'};
  String _selectedCategory = 'Salud';

  void _addHabit() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('El nombre del hábito no puede estar vacío')),
      );
      return;
    }

    setState(() {
      _habits.add(
        Habit(
          id: DateTime.now().toIso8601String(),
          title: _controller.text.trim(),
          category: _selectedCategory,
        ),
      );
      _controller.clear();
    });
    Navigator.pop(context);
  }

  void _toggleHabit(int index) {
    setState(() {
      _habits[index].isCompleted = !_habits[index].isCompleted;
    });
  }

  void _showAddHabitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nuevo Hábito'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: 'Ej. Caminar 30 min'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _addHabit,
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cálculo del progreso usando Map y operaciones de filtrado
    int completedCount = _habits.where((h) => h.isCompleted).length;
    double progress = _habits.isEmpty ? 0.0 : completedCount / _habits.length;

    // Uso de Map para agrupar estadísticas por categoría
    Map<String, int> categorySummary = {};
    for (var habit in _habits) {
      categorySummary[habit.category] =
          (categorySummary[habit.category] ?? 0) + (habit.isCompleted ? 1 : 0);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('BeHealthy - Hábitos'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Icono representativo en lugar de imagen local
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Divider(height: 32, thickness: 1),
          Expanded(
            child: _habits.isEmpty
                ? const Center(
                    child: Text(
                      'No hay hábitos registrados.\n¡Agrega uno nuevo para empezar!',
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
                            onChanged: (bool? value) => _toggleHabit(index),
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
                            color:
                                habit.isCompleted ? Colors.teal : Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitDialog,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
