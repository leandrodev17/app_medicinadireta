import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/const_colors.dart';
import '../../core/responsive/orientation_layout.dart';
import '../../core/responsive/screen_type_layout.dart';

class RevenuesScreen extends StatefulWidget {
  const RevenuesScreen({Key? key}) : super(key: key);

  @override
  State<RevenuesScreen> createState() => _RevenuesScreenState();
}

class _RevenuesScreenState extends State<RevenuesScreen> {
  @override
  Widget build(BuildContext context) {
   return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => Container(color: ConstColors.white,),
        landscape: (context) => Container(),
      ),
      tablet: Container(),
      desktop: Container(),
    );
  }
  
}