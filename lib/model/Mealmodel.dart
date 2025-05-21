class Meal {
  final String name;
  final String imageUrl;
  final String description;
  final String rate;
  final String time;

  // Constructor
  Meal({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.rate,
    required this.time,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      rate: json['rate'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'rate': rate,
      'time': time,
    };
  }
}
