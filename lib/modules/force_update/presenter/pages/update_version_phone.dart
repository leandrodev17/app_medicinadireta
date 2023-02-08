import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/widgets/app_will_pop_scope.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/modules/force_update/presenter/controller/update_version_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateVersionPhone extends StatelessWidget {
  UpdateVersionPhone({Key? key}) : super(key: key);
  final _app = Get.find<UpdateVersionAppController>();

  @override
  Widget build(BuildContext context) {
    // final _app = Modular.get<AppController>();
    final _style1 = TextStyle(fontSize: 25, color: ConstColors.blue, fontWeight: FontWeight.w500);
    final _style2 = TextStyle(fontSize: 20, color: ConstColors.orange, fontWeight: FontWeight.w400);
    return AppWillPopScope(
      onWillPop: () async => Future.value(false),
      child: Scaffold(
        appBar: AppBarDefault.bar(
          showIconBackTop: false,
          title: Text("ÁREA DE ATUALIZAÇÃO"),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ConstDrawables.logo, height: 150),
                const SizedBox(height: 25),
                Text(
                  "Versão desatualizada.",
                  style: _style1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text("Por favor, baixe a nova versão do aplicativo disponível, clique no botão abaixo.", style: _style2, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                AppButton(
                  minWidth: MediaQuery.of(context).size.width - 50,
                  colorBackground: ConstColors.blue,
                  onPressed: () async => await _app.forceUpdateToPlatform(),
                  childRaisedButton: RenderWhen(text: 'Atualizar'),
                )
                // ButtonApp(
                //   onPressed: () async => await _app.forceUpdateToPlatform(context),
                //   childRaisedButton: Text(Helpers.stringTranslated('buttonNameUpdate'), style: _style3),
                //   colorBackground: ConstColors.primary,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
