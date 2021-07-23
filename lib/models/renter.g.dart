// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'renter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RenterAdapter extends TypeAdapter<Renter> {
  @override
  final int typeId = 3;

  @override
  Renter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Renter(
      renterName: fields[1] as String?,
      identityNo: fields[2] as String?,
      phoneNo: fields[3] as String?,
      address: fields[4] as String?,
      dob: fields[13] as DateTime?,
      houseID: fields[11] as String?,
      roomID: fields[12] as String?,
      avatarPath: fields[5] as String?,
      listImagePaths: (fields[6] as List?)?.cast<String>(),
    )
      ..renterID = fields[0] as String
      ..createdBy = fields[7] as String
      ..lastModifiedBy = fields[8] as String
      ..created = fields[9] as DateTime
      ..lastModified = fields[10] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Renter obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.renterID)
      ..writeByte(1)
      ..write(obj.renterName)
      ..writeByte(2)
      ..write(obj.identityNo)
      ..writeByte(3)
      ..write(obj.phoneNo)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.avatarPath)
      ..writeByte(6)
      ..write(obj.listImagePaths)
      ..writeByte(7)
      ..write(obj.createdBy)
      ..writeByte(8)
      ..write(obj.lastModifiedBy)
      ..writeByte(9)
      ..write(obj.created)
      ..writeByte(10)
      ..write(obj.lastModified)
      ..writeByte(11)
      ..write(obj.houseID)
      ..writeByte(12)
      ..write(obj.roomID)
      ..writeByte(13)
      ..write(obj.dob);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RenterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
