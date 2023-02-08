import 'package:medicinadireta/core/page_not_access/presenter/pages/page_not_access_phone.dart';
import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:flutter/material.dart';

class PageNotAccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => PageNotAccessPhone(),
        landscape: (context) => PageNotAccessPhone(),
      ),
      tablet: PageNotAccessPhone(),
      desktop: PageNotAccessPhone(),
    );
  }
}
