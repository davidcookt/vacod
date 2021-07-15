// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseAdapter extends TypeAdapter<House> {
  @override
  final int typeId = 0;

  @override
  House read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return House()
      ..name = fields[0] as String
      ..formID = fields[1] as String
      ..houseID = fields[2] as String
      ..createdBy = fields[3] as String
      ..lastModifiedBy = fields[4] as String
      ..created = fields[5] as DateTime
      ..lastModified = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, House obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.formID)
      ..writeByte(2)
      ..write(obj.houseID)
      ..writeByte(3)
      ..write(obj.createdBy)
      ..writeByte(4)
      ..write(obj.lastModifiedBy)
      ..writeByte(5)
      ..write(obj.created)
      ..writeByte(6)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
