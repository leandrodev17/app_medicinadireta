import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/patient_information/presenter/controller/patient_datails_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key? key}) : super(key: key);
}

abstract class BaseState<Page extends BasePage> extends State<Page> {
  ParamsToNavigationPage? screenCardPatient();
  PreferredSizeWidget? appBar();
  String screenName();
  AppBottomNavigationBar? bottomNavigationBar();
  Function()? onPressedLeading();
  Widget? floatingActionButton();
  List<Widget>? actions();
}

mixin BasicPage<Page extends BasePage> on BaseState<Page> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: ConstColors.backgroundDefault,
        bottomNavigationBar: bottomNavigationBar() ?? bottomNavigationBar(),
        floatingActionButtonLocation: floatingActionButton() == null ? null : FloatingActionButtonLocation.endDocked,
        floatingActionButton: floatingActionButton(),
        body: SafeArea(
          child: AppScaffold(
            appBar: appBar() ??
                AppBarDefault.bar(titleApp: screenName(), elevation: 1, toolbarHeight: 55, leadingSizeIcon: 25, onPressedLeading: onPressedLeading(), actions: actions()),
            backgroundColor: ConstColors.backgroundDefault,
            body: Container(
              color: ConstColors.backgroundDefault,
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
              child: Column(
                children: [
                  Visibility(visible: screenCardPatient() != null, child: CardPatientMixins(params: screenCardPatient() ?? ParamsToNavigationPage())),
                  const SizedBox(height: 10),
                  Expanded(child: body()),
                ],
              ),
            ),
          ),
        ));
  }

  Widget body();
}

class CardPatientMixins extends StatelessWidget {
  final _controller = Get.find<PatientDetailsController>();

  final ParamsToNavigationPage params;

  CardPatientMixins({Key? key, required this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isExistsPhoto = params.photoPerfil != null && (params.photoPerfil?.isNotEmpty ?? false);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: !isExistsPhoto ? null : () => _controller.viewPhoto(params),
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: params.photoPerfil != null
                        ? CircleAvatar(backgroundImage: MemoryImage(params.photoPerfil!))
                        : const Icon(Icons.account_circle, size: 70, color: ConstColors.blue),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Prontuário".toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.greyCard, fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                            decoration: BoxDecoration(
                              color: ConstColors.orange,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              params.numeroDoProtuario?.toString() ?? '--',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              params.nomeDoPaciente?.toUpperCase() ?? '--',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Idade: ${params.idade ?? '--'}".toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.greyCard, fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(color: ConstColors.border),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.mail_outline, size: 18),
                            const SizedBox(width: 5),
                            Text(
                              params.email.toString().isEmail ? params.email.toString() : 'no_email'.tr,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.blue, fontSize: 11, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone_iphone_outlined, size: 18),
                            const SizedBox(width: 5),
                            Text(
                              params.telefone?.toUpperCase() ?? 'no_phone'.tr,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.blue, fontSize: 11, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
