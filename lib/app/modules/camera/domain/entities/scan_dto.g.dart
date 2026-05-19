// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScanDTOAdapter extends TypeAdapter<ScanDTO> {
  @override
  final int typeId = 1;

  @override
  ScanDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScanDTO(
      id: fields[0] as String,
      studentId: fields[1] as String,
      evaluationId: fields[2] as String,
      imagePath: fields[3] as String?,
      createdAt: fields[4] as DateTime,
      grade: fields[5] as double?,
      detectedAnswers: (fields[6] as List?)?.cast<int?>(),
    );
  }

  @override
  void write(BinaryWriter writer, ScanDTO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.studentId)
      ..writeByte(2)
      ..write(obj.evaluationId)
      ..writeByte(3)
      ..write(obj.imagePath)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.grade)
      ..writeByte(6)
      ..write(obj.detectedAnswers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScanDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
