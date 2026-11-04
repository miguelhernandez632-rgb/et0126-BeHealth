class Habit {
  final String id;
  final String title;
  final String category;
  bool isCompleted;

  Habit({
    required this.id,
    required this.title,
    required this.category,
    this.isCompleted = false,
  });

  // Método que cumple con el uso de objetos y transformación
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'isCompleted': isCompleted,
      };

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        isCompleted: json['isCompleted'],
      );
}
