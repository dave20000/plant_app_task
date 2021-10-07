import 'dart:convert';

class Plant {
  final int id;
  final String plantAssetString;
  final String plantType;
  final String name;
  final String details;
  final double prize;
  final double minHeight;
  final double maxHeight;
  final double minTemprature;
  final double maxTemprature;
  final String potType;
  Plant({
    required this.id,
    required this.plantAssetString,
    required this.plantType,
    required this.name,
    required this.details,
    required this.prize,
    required this.minHeight,
    required this.maxHeight,
    required this.minTemprature,
    required this.maxTemprature,
    required this.potType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantAssetString': plantAssetString,
      'plantType': plantType,
      'name': name,
      'details': details,
      'prize': prize,
      'minHeight': minHeight,
      'maxHeight': maxHeight,
      'minTemprature': minTemprature,
      'maxTemprature': maxTemprature,
      'potType': potType,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'],
      plantAssetString: map['plantAssetString'],
      plantType: map['plantType'],
      name: map['name'],
      details: map['details'],
      prize: map['prize'],
      minHeight: map['minHeight'],
      maxHeight: map['maxHeight'],
      minTemprature: map['minTemprature'],
      maxTemprature: map['maxTemprature'],
      potType: map['potType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plant.fromJson(String source) => Plant.fromMap(json.decode(source));
}
