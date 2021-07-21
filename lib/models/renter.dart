import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class Renter extends HiveObject {
  @HiveField(0)
  late String renterID;
  @HiveField(1)
  late String renterName;
  @HiveField(2)
  late String identityNo;
  @HiveField(3)
  late String phoneNo;
  @HiveField(4)
  late String address;
  @HiveField(5)
  late String avatarPath;
  @HiveField(6)
  late List<String> listImagePaths;
  @HiveField(7)
  late String createdBy;
  @HiveField(8)
  late String lastModifiedBy;
  @HiveField(9)
  late DateTime created;
  @HiveField(10)
  late DateTime lastModified;
  @HiveField(11)
  late String houseID;
  @HiveField(12)
  late String roomID;
  @HiveField(13)
  late DateTime dob;
}
