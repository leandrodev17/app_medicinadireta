import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomSheet {
  AppBottomSheet._();

  //NÃO ESTÁ SENDO ULTILIZADA ATÉ O MOMENTO

  static Future<dynamic> modalBottomSheet({required Widget widget, Function()? onTap, bool enableDrag = true}) {
    return showModalBottomSheet<void>(
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: ConstColors.blue.withOpacity(.8),
      context: Get.context!,
      isDismissible: false,
      enableDrag: enableDrag, // desabilita o arrasta para baixo
      builder: (BuildContext context) {
        // final _controller = Modular.get<ShowModalBottomSheetController>();
        return Container(
          // decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Observer(builder: (_) {
                //   return InkWell(
                //     onTap: _controller.closeModalBottomSheet ? onTap ?? () => Modular.to.pop() : null,
                //     child: Container(
                //       alignment: Alignment.topRight,
                //       padding: const EdgeInsets.symmetric(vertical: 10),
                //       height: 30,
                //       child: Icon(Icons.close, color: ConstColors.border, size: 25),
                //     ),
                //   );
                // }),
                SizedBox(height: 5),
                widget,
                SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}
