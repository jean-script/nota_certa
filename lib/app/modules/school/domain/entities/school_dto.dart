import 'dart:convert';

class SchoolDTO {
  final String id;
  final String name;

  const SchoolDTO({required this.id, required this.name});

  factory SchoolDTO.fromJson(Map<String, dynamic> json) {
    return SchoolDTO(id: json['id'] as String, name: json['nome'] as String);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': name};
  }

  String toJson() => jsonEncode(toMap());

  factory SchoolDTO.fromRawJson(String source) {
    return SchoolDTO.fromJson(jsonDecode(source));
  }

  SchoolDTO copyWith({String? id, String? name}) {
    return SchoolDTO(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  String toString() {
    return 'SchoolDto(id: $id, name: $name)';
  }
}
