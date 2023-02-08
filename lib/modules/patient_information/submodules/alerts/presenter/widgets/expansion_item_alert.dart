import 'package:medicinadireta/modules/patient_information/presenter/controller/patient_datails_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'expansion_item_title.dart';
import 'item_alert.dart';

class ExpansionItemAlert extends StatelessWidget {
  final PatientDetailsController controller;

  const ExpansionItemAlert({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: ListView.builder(
          itemCount: controller.alerts2.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var _item = controller.alerts2[index];
            return Column(
              children: [
                InkWell(
                  onTap: () => controller.openCardAlert(index),
                  child: ExpansionItemTitle(
                    title: _item.nomeTipoAlerta.toString().toUpperCase(),
                    colorItem: Color(_item.colorTitulo!),
                    openCard: _item.itemOpenCard,
                  ),
                ),
                AnimatedOpacity(
                  opacity: _item.itemOpenCard ? 1.0 : 0.0,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 900),
                  child: Visibility(
                    visible: _item.itemOpenCard,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2.0, color: Color(_item.colorTitulo!)),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.h),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexItem) {
                          SubItemAlert? _itemCad = _item.itens?[index];
                          return ItemAlert(data: _itemCad);
                        },
                        separatorBuilder: (context, indexItem) {
                          return Divider();
                        },
                        itemCount: _item.itens?.length ?? 0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
