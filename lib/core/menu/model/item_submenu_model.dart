import 'package:medicinadireta/constants/const_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ItemSubmenuModel extends Equatable {
  final String? title;
  final Color background;
  final Widget? leading;
  final bool visible;
  final Function()? onTap;
  final String? iconDataImage;
  const ItemSubmenuModel({this.title, this.leading, this.visible = true, this.onTap, this.background = ConstColors.blue, this.iconDataImage});

  @override
  List<Object?> get props => [title, leading, visible, onTap, background, iconDataImage];
}
