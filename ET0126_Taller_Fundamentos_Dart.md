void main() {
  print('=== PARTE 1: Variables y tipos ===\n');

  // Ficha digital del estudiante
  String nombreCompleto = 'Ana María Gómez';
  int edad = 21;
  double promedioAcumulado = 4.25;
  bool estaMatriculado = true;
  List<String> materiasInscritas = ['Móviles', 'Bases de Datos', 'POO'];

  print('--- FICHA DIGITAL DEL ESTUDIANTE ---');
  print('Nombre: $nombreCompleto');
  print('Edad: $edad años');
  print('Promedio Acumulado: $promedioAcumulado');
  print('Estado de Matrícula: ${estaMatriculado ? "ACTIVO" : "INACTIVO"}');
  print('Materias Inscritas: ${materiasInscritas.join(", ")}');
  print('------------------------------------');

  print('\n=== PARTE 2: Null Safety ===\n');

  // Es nullable (String?) porque no todos los estudiantes tienen un apodo.
  String? apodo;

  mostrarApodo(apodo);

  // Asignamos un apodo para probar el otro camino
  apodo = 'Ani';
  mostrarApodo(apodo);

  print('\n=== PARTE 3: Funciones ===\n');

  print('¿Aprueba con 3.0?: ${evaluarAprobacion(3.0) ? "Sí" : "No"}');
  print('¿Aprueba con 2.8?: ${evaluarAprobacion(2.8) ? "Sí" : "No"}');

  List<double> notasSemestre = [4.0, 3.5, 4.8, 2.9];
  List<double> notasVacias = [];

  print('Promedio semestre: ${calcularPromedio(notasSemestre)}');
  print(
    'Promedio lista vacía (Manejo de caso límite): ${calcularPromedio(notasVacias)}',
  );

  print('\n=== PARTE 4: Colecciones ===\n');

  // 1. List: Permite duplicados para registrar asistencias consecutivas o errores
  List<String> asistentes = ['Carlos', 'Sofía', 'Carlos', 'Mateo'];

  // 2. Set: Colección de elementos únicos para los lenguajes conocidos
  Set<String> lenguajesConocidos = {'Dart', 'Python', 'Java'};

  // 3. Map: Relación clave-valor para búsquedas directas por nombre
  Map<String, double> notasEstudiantes = {
    'Carlos': 4.5,
    'Sofía': 3.8,
    'Mateo': 2.9,
  };

  print('Listado de asistentes (con duplicado): $asistentes');

  // Prueba del comportamiento de Set al añadir duplicados:
  lenguajesConocidos.add('Dart'); // No se agregará de nuevo
  lenguajesConocidos.add('C++'); // Se agregará exitosamente
  print('Conjunto de lenguajes únicos: $lenguajesConocidos');

  print('Nota de Sofía en el Map: ${notasEstudiantes['Sofía']}');

  print('\n=== PARTE 5: Control de Flujo ===\n');

  print('--- Problema A: Clasificación de Rendimiento ---');
  List<double> calificacionesCurso = [1.5, 3.2, 4.8, 2.9, 4.0, 4.5, 0.0];
  clasificarRendimiento(calificacionesCurso);

  print('\n--- Problema B: Control de Intentos de Acceso ---');
  simularInscripcion('claveSegura123');

  print('\n=== PARTE 6: Clases y Programación Orientada a Objetos ===\n');

  List<Estudiante> estudiantes = [
    Estudiante(
      id: 'E001',
      nombre: 'Lucas Modric',
      promedioMinimoRequerido: 3.0,
      notas: [3.5, 4.0, 3.8],
    ),
    Estudiante(
      id: 'E002',
      nombre: 'Mariana Ríos',
      promedioMinimoRequerido: 3.5,
      notas: [2.0, 3.0, 2.5], // No está al día
    ),
    Estudiante(
      id: 'E003',
      nombre: 'David Villa',
      promedioMinimoRequerido: 3.0,
      notas: [], // Caso límite: Sin notas aún
    ),
  ];

  for (var est in estudiantes) {
    print('Estudiante: ${est.nombre}');
    print('  Promedio: ${est.calcularPromedio().toStringAsFixed(2)}');
    print('  ¿Está al día?: ${est.estaAlDia() ? "SÍ" : "NO"}\n');
  }

  print('\n=== RETO INTEGRADOR: Sistema de Gestión de Tareas ===\n');

  GestorTareas gestor = GestorTareas();

  // Mínimo 5 tareas iniciales
  gestor.agregarTarea(
    Tarea(id: 1, titulo: 'Inscribir asignaturas', prioridad: Prioridad.alta),
  );
  gestor.agregarTarea(
    Tarea(id: 2, titulo: 'Comprar cuadernos', prioridad: Prioridad.baja),
  );
  gestor.agregarTarea(
    Tarea(
      id: 3,
      titulo: 'Estudiar para examen de Dart',
      prioridad: Prioridad.alta,
    ),
  );
  gestor.agregarTarea(
    Tarea(id: 4, titulo: 'Pagar matrícula', prioridad: Prioridad.media),
  );
  gestor.agregarTarea(
    Tarea(
      id: 5,
      titulo: 'Revisar correo institucional',
      prioridad: Prioridad.baja,
    ),
  );

  // Completar algunas tareas
  gestor.marcarComoCompletada(1);
  gestor.marcarComoCompletada(4);

  // Mostrar informe
  gestor.mostrarInforme();
}

// ==========================================
// FUNCIONES Y CLASES SOPORTE
// ==========================================

// -- Parte 2 --
void mostrarApodo(String? apodo) {
  if (apodo != null && apodo.isNotEmpty) {
    print('Apodo del estudiante: $apodo');
  } else {
    print('El estudiante no tiene un apodo registrado.');
  }
}

// -- Parte 3 --
// Función flecha para evaluación simple
bool evaluarAprobacion(double nota) => nota >= 3.0;

// Función con cuerpo estructurado y control de casos límite
double calcularPromedio(List<double> notas) {
  if (notas.isEmpty) return 0.0;

  double sumaTotal = 0.0;
  for (double nota in notas) {
    sumaTotal += nota;
  }
  return sumaTotal / notas.length;
}

// -- Parte 5 --
void clasificarRendimiento(List<double> notas) {
  int reprobados = 0;
  int aprobados = 0;
  int sobresalientes = 0;

  for (double nota in notas) {
    if (nota < 0.0 || nota > 5.0) {
      continue; // Ignorar o manejar notas fuera de rango válido
    }

    if (nota < 3.0) {
      reprobados++;
    } else if (nota <= 4.2) {
      aprobados++;
    } else {
      sobresalientes++;
    }
  }

  print('Estadísticas del curso:');
  print(' - Reprobados (< 3.0): $reprobados');
  print(' - Aprobados (3.0 - 4.2): $aprobados');
  print(' - Sobresalientes (> 4.2): $sobresalientes');
}

void simularInscripcion(String claveCorrecta) {
  List<String> intentosIngresados = ['1234', 'password', 'claveSegura123'];
  int maxIntentos = 3;
  int intentosUsados = 0;
  bool accesoConcedido = false;

  while (intentosUsados < maxIntentos && !accesoConcedido) {
    String claveIngresada = intentosIngresados[intentosUsados];
    intentosUsados++;

    if (claveIngresada == claveCorrecta) {
      accesoConcedido = true;
      print('Intento $intentosUsados: Contraseña correcta. Acceso concedido.');
    } else {
      print('Intento $intentosUsados: Contraseña incorrecta.');
    }
  }

  if (!accesoConcedido) {
    print('Se han agotado los $maxIntentos intentos. Acceso bloqueado.');
  }
}

// -- Parte 6 --
class Estudiante {
  final String id;
  final String nombre;
  final double promedioMinimoRequerido;
  final List<double> notas;

  Estudiante({
    required this.id,
    required this.nombre,
    required this.promedioMinimoRequerido,
    required this.notas,
  });

  double calcularPromedio() {
    if (notas.isEmpty) return 0.0;
    double suma = notas.reduce((acumulado, actual) => acumulado + actual);
    return suma / notas.length;
  }

  bool estaAlDia() {
    if (notas.isEmpty) return false;
    return calcularPromedio() >= promedioMinimoRequerido;
  }
}

// -- Reto Integrador --
enum Prioridad { baja, media, alta }

class Tarea {
  final int id;
  final String titulo;
  final Prioridad prioridad;
  bool completada;
  final DateTime? fechaLimite; // Preparado para cambios futuros

  Tarea({
    required this.id,
    required this.titulo,
    required this.prioridad,
    this.completada = false,
    this.fechaLimite,
  });

  void completar() {
    completada = true;
  }

  @override
  String toString() {
    String estado = completada ? '[✓] Completada' : '[ ] Pendiente';
    String etiquetaPrioridad = prioridad.name.toUpperCase();
    return '$estado | ID: $id | ($etiquetaPrioridad) $titulo';
  }
}

class GestorTareas {
  final List<Tarea> _tareas = [];

  void agregarTarea(Tarea tarea) {
    _tareas.add(tarea);
  }

  void marcarComoCompletada(int idTarea) {
    for (var tarea in _tareas) {
      if (tarea.id == idTarea) {
        tarea.completar();
        break;
      }
    }
  }

  int contarPendientes() {
    return _tareas.where((tarea) => !tarea.completada).length;
  }

  Map<Prioridad, int> contarPorPrioridad() {
    Map<Prioridad, int> conteo = {
      Prioridad.baja: 0,
      Prioridad.media: 0,
      Prioridad.alta: 0,
    };

    for (var tarea in _tareas) {
      conteo[tarea.prioridad] = (conteo[tarea.prioridad] ?? 0) + 1;
    }

    return conteo;
  }

  void mostrarInforme() {
    print('========================================');
    print('       LISTADO GENERAL DE TAREAS        ');
    print('========================================');

    if (_tareas.isEmpty) {
      print('No hay tareas en el sistema.');
      return;
    }

    for (var tarea in _tareas) {
      print(tarea);
    }

    print('----------------------------------------');
    print('Tareas pendientes: ${contarPendientes()}');

    print('\nConteo por Prioridad (Bonus):');
    Map<Prioridad, int> conteoPrioridades = contarPorPrioridad();
    conteoPrioridades.forEach((prioridad, cantidad) {
      print(' - ${prioridad.name.toUpperCase()}: $cantidad');
    });
    print('========================================');
  }
}
