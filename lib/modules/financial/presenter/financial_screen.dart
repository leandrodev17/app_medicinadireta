import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/financial/presenter/pages/financial_phone.dart';
import 'package:flutter/material.dart';

class FinancialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => FinancialPhone(),
        landscape: (context) => FinancialPhone(),
      ),
      tablet: FinancialPhone(),
      desktop: FinancialPhone(),
    );
  }
}
