import 'package:hive/hive.dart';
part 'house.g.dart';

@HiveType(typeId: 0)
class House extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String formID;
  @HiveField(2)
  late String houseID;
  @HiveField(3)
  late String createdBy;
  @HiveField(4)
  late String lastModifiedBy;
  @HiveField(5)
  late DateTime created;
  @HiveField(6)
  late DateTime lastModified;
}
