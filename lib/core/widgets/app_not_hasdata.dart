import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNotHasdata extends StatelessWidget {
  final Function()? loadData;
  final bool visibleOnPressed;
  final double? minWidth;
  final String? message;

  AppNotHasdata({Key? key,  this.loadData, this.minWidth, this.message, this.visibleOnPressed = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _message = message != null ? message : "notHashData".tr;
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ConstDrawables.emptyBoxGif, fit: BoxFit.contain, height: MediaQuery.of(context).size.height * .3),
        const SizedBox(height: 20),
        Text(_message!, style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.center),
        const SizedBox(height: 20),
       Visibility(
         visible: visibleOnPressed,
         child: AppButton(
            minWidth: minWidth,
            onPressed: loadData,
            childRaisedButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.refresh, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(child: Text("buttonUpdate".tr, style: Theme.of(context).textTheme.button)),
              ],
            ),
          ),
       ),
      ],
    );
  }
}
