import 'package:medicinadireta/core/responsive/orientation_layout.dart';
import 'package:medicinadireta/core/responsive/screen_type_layout.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/pages/attachments_phone.dart';
import 'package:flutter/material.dart';

class AttachmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => AttachmentsPhone(),
        landscape: (context) => AttachmentsPhone(),
      ),
      tablet: AttachmentsPhone(),
      desktop: AttachmentsPhone(),
    );
  }
}