// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceAdapter extends TypeAdapter<Service> {
  @override
  final int typeId = 1;

  @override
  Service read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Service()
      ..serviceID = fields[0] as String
      ..formServiceID = fields[1] as String
      ..serviceName = fields[2] as String
      ..houseID = fields[3] as String
      ..unitPrice = fields[4] as int
      ..createdBy = fields[5] as String
      ..lastModifiedBy = fields[6] as String
      ..created = fields[7] as DateTime
      ..lastModified = fields[8] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Service obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.serviceID)
      ..writeByte(1)
      ..write(obj.formServiceID)
      ..writeByte(2)
      ..write(obj.serviceName)
      ..writeByte(3)
      ..write(obj.houseID)
      ..writeByte(4)
      ..write(obj.unitPrice)
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
      other is ServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
