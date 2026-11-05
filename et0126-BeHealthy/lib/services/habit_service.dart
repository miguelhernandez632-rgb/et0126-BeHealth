import '../models/habit.dart';

class HabitService {
  // Lista privada en memoria (simulando una base de datos temporal)
  static final List<Habit> _habits = [
    Habit(
      id: '1',
      title: 'Beber 2L de agua',
      category: 'Salud',
      isCompleted: true,
    ),
    Habit(
      id: '2',
      title: 'Estudiar Flutter 30 min',
      category: 'Estudio',
      isCompleted: false,
    ),
  ];

  // Operación asíncrona para listar con demora simulada
  Future<List<Habit>> listar() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List<Habit>.unmodifiable(_habits);
  }

  // Operación asíncrona para crear con regla de negocio (evitar títulos duplicados)
  Future<Habit> crear(Habit habit) async {
    await Future.delayed(const Duration(milliseconds: 700));

    // Regla de negocio: Verificar si ya existe un hábito con exactamente el mismo título
    final existe = _habits.any(
      (actual) =>
          actual.title.trim().toLowerCase() == habit.title.trim().toLowerCase(),
    );

    if (existe) {
      throw StateError('Ya existe un hábito registrado con este título.');
    }

    _habits.insert(0, habit);
    return habit;
  }
}
