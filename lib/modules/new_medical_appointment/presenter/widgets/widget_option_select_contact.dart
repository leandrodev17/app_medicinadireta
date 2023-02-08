import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/const_colors.dart';
import '../../../../core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import '../../../../core/validators/app_validators.dart';
import '../controller/new_medical_appointment_controller.dart';

class WidgetOptionSelectContact extends StatelessWidget {
  final NewMedicalAppointmentController controller;

  const WidgetOptionSelectContact({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? selectedItemSelectContact;
    return Obx(() {
      return AppDropdownWidgetSearchImpl(
        isDecorationNotBorder: true,
        items: controller.listContacts.isNotEmpty ? controller.listContacts.map((e) => e.toMap()).toList() : [],
        itemAsString: (dynamic value) => value['nome'].toString(),
        selectedItem: selectedItemSelectContact,
        onChanged: controller.onChangeContacts,
        hintText: 'Selecionar um compromisso*',
        prefixIcon: const Icon(Icons.schedule, color: ConstColors.scheduleGridColorText),
        suffixIcon: const Icon(Icons.schedule, color: ConstColors.scheduleGridColorText),
        borderSideColor: ConstColors.scheduleGridColor,
        validator: AppValidators.required(m: 'Selecionar um compromisso*'),
        hintStyle: GoogleFonts.openSans(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: ConstColors.scheduleGridColorText,
        ),
      );
    });
  }
}
