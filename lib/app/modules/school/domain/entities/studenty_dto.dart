import 'dart:convert';

class StudentDTO {
  final String id;
  final String classroomId;
  final String name;
  final String registration;

  const StudentDTO({
    required this.id,
    required this.classroomId,
    required this.name,
    required this.registration,
  });

  factory StudentDTO.fromJson(Map<String, dynamic> json) {
    return StudentDTO(
      id: json['id'],
      classroomId: json['turma_id'],
      name: json['nome'],
      registration: json['matricula'],
    );
  }

  factory StudentDTO.fromRawJson(String source) {
    return StudentDTO.fromJson(jsonDecode(source));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'turma_id': classroomId,
      'nome': name,
      'matricula': registration,
    };
  }

  String toJson() => jsonEncode(toMap());

  StudentDTO copyWith({
    String? id,
    String? classroomId,
    String? name,
    String? registration,
  }) {
    return StudentDTO(
      id: id ?? this.id,
      classroomId: classroomId ?? this.classroomId,
      name: name ?? this.name,
      registration: registration ?? this.registration,
    );
  }

  @override
  String toString() {
    return '''
StudentDto(
  id: $id,
  classroomId: $classroomId,
  name: $name,
  registration: $registration
)
''';
  }
}
