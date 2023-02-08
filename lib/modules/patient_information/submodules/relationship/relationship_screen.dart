import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/presenter/pages/relationship_phone.dart';
import 'package:flutter/material.dart';

class RelationshipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => RelationshipPhone(),
        landscape: (context) => RelationshipPhone(),
      ),
      tablet: RelationshipPhone(),
      desktop: RelationshipPhone(),
    );
  }
}
