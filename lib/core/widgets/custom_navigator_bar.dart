import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

List<BottomNavigationBarItem> customNavigationBar({currentPag = 0}) {
  List<BottomNavigationBarItem> _menus = [
    BottomNavigationBarItem(
      icon: Icon(Icons.person_add_outlined, color: ConstColors.blue),
      label: "Paciente",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu_outlined, color: ConstColors.blue),
      label: "Menu",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.date_range_outlined, color: ConstColors.blue),
      label: "Agenda",
    ),
  ];
  return _menus;
}