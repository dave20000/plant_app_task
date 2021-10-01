import 'dart:convert';

class Plant {
  final int id;
  final String plantType;
  final String name;
  final String details;
  final double prize;
  Plant({
    required this.id,
    required this.plantType,
    required this.name,
    required this.details,
    required this.prize,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantType': plantType,
      'name': name,
      'details': details,
      'prize': prize,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'],
      plantType: map['plantType'],
      name: map['name'],
      details: map['details'],
      prize: map['prize'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plant.fromJson(String source) => Plant.fromMap(json.decode(source));
}
