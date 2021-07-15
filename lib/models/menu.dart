import 'package:flutter/material.dart';
import 'package:vacod/utils/colors.dart';

List<Map<String, dynamic>> listMenus = [
  {
    'title': 'Quản lý nhà',
    'color': lightAccentColor,
    'image': Icon(Icons.ac_unit),
  },
  {
    'title': 'Quản lý phòng',
    'color': lightAccentColor,
    'image': Icon(Icons.ac_unit),
  },
  {
    'title': 'Quản lý dịch vụ',
    'color': lightAccentColor,
    'image': Icon(Icons.ac_unit),
  },
  {
    'title': 'Quản lý điện nước',
    'color': lightAccentColor,
    'image': Icon(Icons.ac_unit),
  },
  {
    'title': 'Quản lý khách thuê',
    'color': lightAccentColor,
    'image': Icon(Icons.ac_unit),
  },
  {
    'title': 'Hoá đơn',
    'color': lightAccentColor,
    'image': Icon(Icons.ac_unit),
  }
];

class MenuModel {
  String? title;
  Color? color;
  Widget? image;
  MenuModel({
    this.title,
    this.color,
    this.image,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      title: json['title'],
      color: json['color'],
      image: json['image'],
    );
  }
}
