import 'dart:typed_data';

import 'package:google_fonts/google_fonts.dart';
import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'form/app_button_simple.dart';

class CardListPatientFinance extends StatelessWidget {
  final String? name;
  final String? prontuario;
  final Uint8List? foto;
  final Function()? onTap;
  final bool isAddAppointment;

  const CardListPatientFinance({Key? key, this.name, this.prontuario, this.foto, this.onTap, this.isAddAppointment = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: InkWell(
          onTap: foto != null
              ? () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Visualização rápida", style: Theme.of(context).textTheme.subtitle2),
                        content: Image.memory(foto!),
                        actions: [AppButtonSimple(onPressed: () => Navigator.pop(context), backgroundColor: ConstColors.orange, child: Text("close".tr))],
                      );
                    },
                  )
              : null,
          child: SizedBox(
            height: 45.hEx,
            width: 45.wEx,
            child: foto != null ? CircleAvatar(backgroundImage: MemoryImage(foto!)) : Icon(Icons.account_circle, size: 45.hEx, color: ConstColors.blue),
          ),
        ),
        title: InkWell(
          onTap: onTap, //() async => await Get.toNamed(Routes.PATIENT_DETAILS, arguments: newParams),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name ?? "no_value".tr,
                      style: GoogleFonts.openSans(fontSize: 16.spEx, color: ConstColors.blue, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Prontuário: ",
                    style: GoogleFonts.openSans(color: ConstColors.greyCard, fontSize: 13.spEx, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    prontuario?.toString() ?? "no_value".tr,
                    style: GoogleFonts.openSans(color: ConstColors.orange, fontSize: 14.spEx, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ],
          ),
        ),
        trailing: InkWell(
          onTap: onTap, //() async => await Get.toNamed(Routes.PATIENT_DETAILS, arguments: newParams),
          child: Icon(isAddAppointment ? Icons.add : Icons.keyboard_arrow_right, color: ConstColors.orange, size: 30),
        ),
      ),
    );
  }
}
