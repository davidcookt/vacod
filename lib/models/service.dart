import 'package:hive/hive.dart';
part 'service.g.dart';

@HiveType(typeId: 1)
class Service extends HiveObject {
  @HiveField(0)
  late String serviceID;
  @HiveField(1)
  late String formServiceID;
  @HiveField(2)
  late String serviceName;
  @HiveField(3)
  late String houseID;
  @HiveField(4)
  late int unitPrice;
  @HiveField(5)
  late String createdBy;
  @HiveField(6)
  late String lastModifiedBy;
  @HiveField(7)
  late DateTime created;
  @HiveField(8)
  late DateTime lastModified;
}
