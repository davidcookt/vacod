import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:vacod/models/room.dart';

class RoomProvider extends ChangeNotifier {
  static const String _boxName = 'room';

  List<Room> _rooms = [];
  Room? _activeRoom;
  bool? isLoading = false, isLoaded = false, isFailed = false;
  bool? isNotFound = false;

  void getRooms() async {
    isLoading = true;

    // isFailed = false;
    // isLoaded = false;
    notifyListeners();

    // print(isLoaded);
    try {
      var box = await Hive.openBox<Room>(_boxName);
      _rooms = box.values.toList();
    } catch (e) {
      isFailed = true;
      print('get Rooms Failed $e');
    }
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isLoading = false;
      isNotFound = false;
      isFailed = false;
      notifyListeners();
    });
  }

  Room getRoom(index) {
    return _rooms[index];
  }

  void filterRoom(String filterName) async {
    isLoading = true;
    notifyListeners();
    try {
      var box = await Hive.openBox<Room>(_boxName);
      if (filterName.length > 0) {
        _rooms = box.values
            .toList()
            .where((element) => element.name.contains(filterName))
            .toList();
        if (_rooms.isEmpty) {
          isNotFound = true;
        } else {
          isNotFound = false;
        }
      }
    } catch (e) {
      print('filter Room Failed $e');
    }
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isLoading = false;
      notifyListeners();
    });
  }

  void addRoom(String name, String houseID, int rent, int deposit) async {
    try {
      isLoading = true;
      EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
      notifyListeners();
      var box = await Hive.openBox<Room>(_boxName);
      var room = Room()
        ..roomID = Uuid().v1()
        ..name = name
        ..houseID = houseID
        ..rent = rent
        ..deposit = deposit
        ..created = DateTime.now()
        ..createdBy = 'abc'
        ..lastModified = DateTime.now()
        ..lastModifiedBy = 'abc';
      await box.add(room);
      _rooms = box.values.toList();
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        isLoading = false;
        EasyLoading.showSuccess('Thêm phòng thành công', dismissOnTap: true);
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void updateRoom(
      String name, String houseID, String roomID, int deposit, int rent) async {
    EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
    var box = await Hive.openBox<Room>(_boxName);
    final Map<dynamic, Room> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.roomID == roomID) desiredKey = key;
    });
    var house = box.get(desiredKey);
    var newRoom = Room()
      ..roomID = roomID
      ..name = name
      ..houseID = houseID
      ..deposit = deposit
      ..rent = rent
      ..created = house?.created ?? DateTime.now()
      ..createdBy = house?.createdBy ?? 'xyz'
      ..lastModified = DateTime.now()
      ..lastModifiedBy = 'abc';

    await box.put(desiredKey, newRoom);
    _rooms = box.values.toList();
    // _activeHouse = box.get(houseKey)!;
    EasyLoading.showSuccess('Sửa phòng thành công', dismissOnTap: true);
    print('Edited ${newRoom.roomID}' + desiredKey.toString());
    notifyListeners();
  }

  void deleteRoom(roomID) async {
    EasyLoading.show(status: 'Đang thực hiện', dismissOnTap: true);
    var box = await Hive.openBox<Room>(_boxName);
    final Map<dynamic, Room> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.houseID == roomID) desiredKey = key;
    });
    print(desiredKey);
    await box.delete(desiredKey);
    // await box.delete(key);

    _rooms = box.values.toList();
    EasyLoading.showSuccess('Xoá phòng thành công', dismissOnTap: true);
    print('Deleted member with key' + roomID.toString());
    notifyListeners();
  }

  Future<void> getDetailRoom(roomID) async {
    isLoading = true;
    notifyListeners();
    try {
      var box = await Hive.openBox<Room>(_boxName);
      _activeRoom =
          box.values.where((element) => element.roomID == roomID).first;
      print(_activeRoom?.name);
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print('Get Detail House Failed $e');
    }
  }

  Future<String> getHouseName(roomID) async {
    try {
      var box = await Hive.openBox<Room>(_boxName);
      var currentRoom =
          box.values.where((element) => element.roomID == roomID).first;
      return currentRoom.name;
    } catch (e) {
      print('Get Detail Room Failed $e');
      return '';
    }
  }

  Room get getActiveRoom => _activeRoom!;

  int get roomCount => _rooms.length;
}
