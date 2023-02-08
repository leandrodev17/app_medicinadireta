import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNotConnecting extends StatelessWidget {
  final Function()? loadData;
  final double? minWidth;

  AppNotConnecting({Key? key, this.loadData, this.minWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(ConstDrawables.noNetworkAccess, fit: BoxFit.contain, height: MediaQuery.of(context).size.height * .4),
        const SizedBox(height: 20),
        Text("no_network_access".tr, style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.center),
        const SizedBox(height: 20),
        AppButton(
          minWidth: minWidth,
          onPressed: loadData,
          childRaisedButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.refresh, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text("buttonUpdate".tr, style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white))),
            ],
          ),
        ),
      ],
    );
  }
}
