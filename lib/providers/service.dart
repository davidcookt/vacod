import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:vacod/models/house.dart';
import 'package:vacod/models/service.dart';

class ServiceProvider extends ChangeNotifier {
  static const String _boxName = 'service';

  List<Service> _services = [];
  Service? _activeService;
  bool? isLoading = false, isLoaded = false, isFailed = false;
  bool? isNotFound = false;

  void getServices() async {
    isLoading = true;
    notifyListeners();
    try {
      var box = await Hive.openBox<Service>(_boxName);
      _services = box.values.toList();
    } catch (e) {
      print('get Service Failed $e');
      isFailed = true;
    }
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      if (!isFailed!) {
        isLoading = false;
        isNotFound = false;
        isFailed = false;
      }
      notifyListeners();
    });
  }

  Service getService(index) {
    return _services[index];
  }

  int get serviceCount => _services.length;
  List<Service> get services => _services;

  void addService(String serviceName, String houseID, String formServiceID,
      int unitPrice) async {
    try {
      isLoading = true;
      EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
      notifyListeners();
      var box = await Hive.openBox<Service>(_boxName);
      var service = Service()
        ..serviceID = Uuid().v1()
        ..serviceName = serviceName
        ..houseID = houseID
        ..formServiceID = formServiceID
        ..unitPrice = unitPrice
        ..created = DateTime.now()
        ..createdBy = 'abc'
        ..lastModified = DateTime.now()
        ..lastModifiedBy = 'abc';
      await box.add(service);
      _services = box.values.toList();
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        isLoading = false;
        EasyLoading.showSuccess('Thêm Dịch vụ thành công', dismissOnTap: true);
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void updateService(
    String serviceName,
    String formServiceID,
    String serviceID,
    String houseID,
    int unitPrice,
  ) async {
    EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
    var box = await Hive.openBox<Service>(_boxName);
    final Map<dynamic, Service> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.serviceID == serviceID) desiredKey = key;
    });
    var house = box.get(desiredKey);
    var newService = Service()
      ..serviceID = Uuid().v1()
      ..serviceName = serviceName
      ..houseID = houseID
      ..formServiceID = formServiceID
      ..unitPrice = unitPrice
      ..created = house?.created ?? DateTime.now()
      ..createdBy = house?.createdBy ?? 'xyz'
      ..lastModified = DateTime.now()
      ..lastModifiedBy = 'abc';

    await box.put(desiredKey, newService);
    _services = box.values.toList();
    // _activeHouse = box.get(houseKey)!;
    EasyLoading.showSuccess('Sửa dịch vụ thành công', dismissOnTap: true);
    print('Edited ${newService.serviceID}' + desiredKey.toString());
    notifyListeners();
  }

  void deleteService(serviceID) async {
    EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
    var box = await Hive.openBox<Service>(_boxName);
    final Map<dynamic, Service> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.houseID == serviceID) desiredKey = key;
    });
    print(desiredKey);
    await box.delete(desiredKey);
    // await box.delete(key);

    _services = box.values.toList();
    EasyLoading.showSuccess('Xoá dịch vụ thành công', dismissOnTap: true);
    print('Deleted member with key' + serviceID.toString());
    notifyListeners();
  }

  Future<void> getDetailService(serviceID) async {
    isLoading = true;
    notifyListeners();
    try {
      var box = await Hive.openBox<Service>(_boxName);
      _activeService =
          box.values.where((element) => element.serviceID == serviceID).first;
      // print(_activeService?.serviceName);
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print('Get Detail House Failed $e');
    }
  }

  Service get getActiveService => _activeService!;

  void filterService(String filterName) async {
    isLoading = true;
    notifyListeners();
    try {
      var box = await Hive.openBox<Service>(_boxName);
      if (filterName.length > 0) {
        _services = box.values
            .toList()
            .where((element) => element.serviceName.contains(filterName))
            .toList();
        if (_services.isEmpty) {
          isNotFound = true;
        } else {
          isNotFound = false;
        }
      }
    } catch (e) {
      print('filter Services Failed $e');
    }
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isLoading = false;
      notifyListeners();
    });
  }
}
