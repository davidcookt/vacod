import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:vacod/models/house.dart';

class HouseProvider extends ChangeNotifier {
  static const String _boxName = 'house';

  List<House> _houses = [];
  House? _activeHouse;
  bool? isLoading = false, isLoaded = false, isFailed = false;
  bool? isNotFound = false;
  String? _houseName;
  void getHouses() async {
    isLoading = true;

    // isFailed = false;
    // isLoaded = false;
    notifyListeners();

    // print(isLoaded);
    try {
      var box = await Hive.openBox<House>(_boxName);
      _houses = box.values.toList();
    } catch (e) {
      isFailed = true;
      print('get Houses Failed $e');
    }
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isLoading = false;
      isNotFound = false;
      isFailed = false;
      notifyListeners();
    });
  }

  House getHouse(index) {
    return _houses[index];
  }

  void filterHouse(String filterName) async {
    isLoading = true;
    notifyListeners();
    try {
      var box = await Hive.openBox<House>(_boxName);
      if (filterName.length > 0) {
        _houses = box.values
            .toList()
            .where((element) => element.name.contains(filterName))
            .toList();
        if (_houses.isEmpty) {
          isNotFound = true;
        } else {
          isNotFound = false;
        }
      }
    } catch (e) {
      print('filter Houses Failed $e');
    }
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isLoading = false;
      notifyListeners();
    });
  }

  void addHouse(String name, String formId) async {
    try {
      isLoading = true;
      EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
      notifyListeners();
      var box = await Hive.openBox<House>(_boxName);
      var house = House()
        ..houseID = Uuid().v1()
        ..name = name
        ..formID = formId
        ..created = DateTime.now()
        ..createdBy = 'abc'
        ..lastModified = DateTime.now()
        ..lastModifiedBy = 'abc';
      await box.add(house);
      _houses = box.values.toList();
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        isLoading = false;
        EasyLoading.showSuccess('Thêm nhà thành công', dismissOnTap: true);
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void updateHouse(String name, String formId, String houseKey) async {
    EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
    var box = await Hive.openBox<House>(_boxName);
    final Map<dynamic, House> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.houseID == houseKey) desiredKey = key;
    });
    var house = box.get(desiredKey);
    var newHouse = House()
      ..houseID = houseKey
      ..name = name
      ..formID = formId
      ..created = house?.created ?? DateTime.now()
      ..createdBy = house?.createdBy ?? 'xyz'
      ..lastModified = DateTime.now()
      ..lastModifiedBy = 'abc';

    await box.put(desiredKey, newHouse);
    _houses = box.values.toList();
    // _activeHouse = box.get(houseKey)!;
    EasyLoading.showSuccess('Sửa nhà thành công', dismissOnTap: true);
    print('Edited ${newHouse.formID}' + desiredKey.toString());
    notifyListeners();
  }

  void deleteHouse(houseKey) async {
    EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
    var box = await Hive.openBox<House>(_boxName);
    final Map<dynamic, House> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.houseID == houseKey) desiredKey = key;
    });
    print(desiredKey);
    await box.delete(desiredKey);
    // await box.delete(key);

    _houses = box.values.toList();
    EasyLoading.showSuccess('Xoá nhà thành công', dismissOnTap: true);
    print('Deleted member with key' + houseKey.toString());
    notifyListeners();
  }

  void setActiveHouse(houseKey) async {
    var box = await Hive.openBox<House>(_boxName);
    // _activeHouse = box.containsKey(key);
    print(_activeHouse?.name);
    notifyListeners();
  }

  Future<void> getDetailHouse(houseKey) async {
    isLoading = true;
    notifyListeners();
    try {
      var box = await Hive.openBox<House>(_boxName);
      _activeHouse =
          box.values.where((element) => element.houseID == houseKey).first;
      print(_activeHouse?.name);
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print('Get Detail House Failed $e');
    }
  }

  Future<String> getHouseName(houseID) async {
    try {
      var box = await Hive.openBox<House>(_boxName);
      var currentHouse =
          box.values.where((element) => element.houseID == houseID).first;
      return currentHouse.name;
    } catch (e) {
      print('Get Detail House Failed $e');
      return '';
    }
  }

  House get getActiveHouse => _activeHouse!;

  int get houseCount => _houses.length;
}
