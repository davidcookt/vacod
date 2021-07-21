// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoomAdapter extends TypeAdapter<Room> {
  @override
  final int typeId = 2;

  @override
  Room read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Room()
      ..name = fields[0] as String
      ..roomID = fields[1] as String
      ..houseID = fields[2] as String
      ..rent = fields[3] as int
      ..deposit = fields[4] as int
      ..createdBy = fields[5] as String
      ..lastModifiedBy = fields[6] as String
      ..created = fields[7] as DateTime
      ..lastModified = fields[8] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Room obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.roomID)
      ..writeByte(2)
      ..write(obj.houseID)
      ..writeByte(3)
      ..write(obj.rent)
      ..writeByte(4)
      ..write(obj.deposit)
      ..writeByte(5)
      ..write(obj.createdBy)
      ..writeByte(6)
      ..write(obj.lastModifiedBy)
      ..writeByte(7)
      ..write(obj.created)
      ..writeByte(8)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
