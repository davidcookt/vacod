import 'package:hive/hive.dart';
// part 'room.g.dart';

@HiveType(typeId: 3)
class Room extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String roomID;
  @HiveField(2)
  late String houseID;
  @HiveField(3)
  late int rent;
  @HiveField(4)
  late int deposit;
  @HiveField(5)
  late String createdBy;
  @HiveField(6)
  late String lastModifiedBy;
  @HiveField(7)
  late DateTime created;
  @HiveField(8)
  late DateTime lastModified;
}
