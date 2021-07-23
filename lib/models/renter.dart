import 'package:hive/hive.dart';
part 'renter.g.dart';

@HiveType(typeId: 3)
class Renter extends HiveObject {
  @HiveField(0)
  late String renterID;
  @HiveField(1)
  String? renterName;
  @HiveField(2)
  String? identityNo;
  @HiveField(3)
  String? phoneNo;
  @HiveField(4)
  String? address;
  @HiveField(5)
  String? avatarPath;
  @HiveField(6)
  List<String>? listImagePaths;
  @HiveField(7)
  late String createdBy;
  @HiveField(8)
  late String lastModifiedBy;
  @HiveField(9)
  late DateTime created;
  @HiveField(10)
  late DateTime lastModified;
  @HiveField(11)
  String? houseID;
  @HiveField(12)
  String? roomID;
  @HiveField(13)
  DateTime? dob;

  Renter({
    this.renterName,
    this.identityNo,
    this.phoneNo,
    this.address,
    this.dob,
    this.houseID,
    this.roomID,
    this.avatarPath,
    this.listImagePaths,
  });
}
