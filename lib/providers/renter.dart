import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:vacod/models/renter.dart';

class RenterProvider extends ChangeNotifier {
  static const String _boxName = 'renter';

  List<Renter> _renters = [];
  Renter? _activeRenter;
  bool? isLoading = false, isLoaded = false, isFailed = false;
  bool? isNotFound = false;

  void getRenters() async {
    isLoading = true;

    // isFailed = false;
    // isLoaded = false;
    notifyListeners();

    // print(isLoaded);
    try {
      var box = await Hive.openBox<Renter>(_boxName);
      _renters = box.values.toList();
    } catch (e) {
      isFailed = true;
      print('get Renters Failed $e');
    }
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isLoading = false;
      isNotFound = false;
      isFailed = false;
      notifyListeners();
    });
  }

  Renter getRenter(index) {
    return _renters[index];
  }

  void filterRoom(String filterName) async {
    isLoading = true;
    notifyListeners();
    try {
      var box = await Hive.openBox<Renter>(_boxName);
      if (filterName.length > 0) {
        _renters = box.values
            .toList()
            .where((element) => element.renterName!.contains(filterName))
            .toList();
        if (_renters.isEmpty) {
          isNotFound = true;
        } else {
          isNotFound = false;
        }
      }
    } catch (e) {
      print('filter Renter Failed $e');
    }
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isLoading = false;
      notifyListeners();
    });
  }

  void addRenter(Renter newRenter) async {
    try {
      isLoading = true;
      EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
      notifyListeners();
      var box = await Hive.openBox<Renter>(_boxName);
      var renter = Renter()
        ..renterID = Uuid().v1()
        ..renterName = newRenter.renterName
        ..houseID = newRenter.houseID
        ..roomID = newRenter.roomID
        ..dob = newRenter.dob
        ..identityNo = newRenter.identityNo
        ..address = newRenter.address
        ..avatarPath = newRenter.avatarPath
        ..listImagePaths = newRenter.listImagePaths
        ..phoneNo = newRenter.phoneNo
        ..created = DateTime.now()
        ..createdBy = 'abc'
        ..lastModified = DateTime.now()
        ..lastModifiedBy = 'abc';
      await box.add(renter);
      _renters = box.values.toList();
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        isLoading = false;
        EasyLoading.showSuccess('Thêm khách thuê thành công',
            dismissOnTap: true);
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void updateRenter(Renter updateRenter, String renterID) async {
    EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
    var box = await Hive.openBox<Renter>(_boxName);
    final Map<dynamic, Renter> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.renterID == renterID) desiredKey = key;
    });
    var renter = box.get(desiredKey);
    var newRenter = Renter()
      ..renterID = renterID
      ..renterName = updateRenter.renterName
      ..houseID = updateRenter.houseID
      ..roomID = updateRenter.roomID
      ..dob = updateRenter.dob
      ..identityNo = updateRenter.identityNo
      ..address = updateRenter.address
      ..avatarPath = updateRenter.avatarPath
      ..listImagePaths = updateRenter.listImagePaths
      ..phoneNo = updateRenter.phoneNo
      ..created = renter?.created ?? DateTime.now()
      ..createdBy = renter?.createdBy ?? 'xxx'
      ..lastModified = DateTime.now()
      ..lastModifiedBy = 'abc';

    await box.put(desiredKey, newRenter);
    _renters = box.values.toList();
    // _activeHouse = box.get(houseKey)!;
    EasyLoading.showSuccess('Sửa khách thuê thành công', dismissOnTap: true);
    print('Edited ${newRenter.renterID}' + desiredKey.toString());
    notifyListeners();
  }

  Future<void> getDetailRenter(renterID) async {
    isLoading = true;
    notifyListeners();
    try {
      var box = await Hive.openBox<Renter>(_boxName);
      _activeRenter =
          box.values.where((element) => element.renterID == renterID).first;
      // print(_activeRenter?.renterName);
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print('Get Detail Renter Failed $e');
    }
  }

  Renter get getActiveRenter => _activeRenter!;

  int get renterCount => _renters.length;
}
