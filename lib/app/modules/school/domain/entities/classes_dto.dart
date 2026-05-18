import 'dart:convert';

class ClassDTO {
  final String id;
  final String schoolId;
  final String name;
  final int year;

  const ClassDTO({
    required this.id,
    required this.schoolId,
    required this.name,
    required this.year,
  });

  factory ClassDTO.fromJson(Map<String, dynamic> json) {
    return ClassDTO(
      id: json['id'] as String,
      schoolId: json['escola_id'] as String,
      name: json['nome'] as String,
      year: json['ano'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'escola_id': schoolId, 'nome': name, 'ano': year};
  }

  String toJson() => jsonEncode(toMap());

  factory ClassDTO.fromRawJson(String source) {
    return ClassDTO.fromJson(jsonDecode(source));
  }

  ClassDTO copyWith({String? id, String? schoolId, String? name, int? year}) {
    return ClassDTO(
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      name: name ?? this.name,
      year: year ?? this.year,
    );
  }

  @override
  String toString() {
    return 'ClassDto(id: $id, schoolId: $schoolId, name: $name, year: $year)';
  }
}
