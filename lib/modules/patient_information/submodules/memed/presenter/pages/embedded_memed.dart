import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/webview/web_view_app.dart';
import 'package:medicinadireta/modules/patient_information/submodules/memed/presenter/controllers/memed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';

class EmbeddedMemed extends BasePage {
  EmbeddedMemed({Key? key}) : super(key: key);

  @override
  State<EmbeddedMemed> createState() => _EmbeddedMemedState();
}

class _EmbeddedMemedState extends BaseState<EmbeddedMemed> with WidgetsBindingObserver, BasicPage {
  final MemedController _controller = Get.find<MemedController>();

  ParamsToNavigationPage _params = Get.arguments;

  @override
  ParamsToNavigationPage? screenCardPatient() => null;

  @override
  String screenName() => 'memed'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  Widget? floatingActionButton() => null;

  @override
  List<Widget>? actions() => [];

  @override
  AppBottomNavigationBar? bottomNavigationBar() => null;

  @override
  Function()? onPressedLeading() => () async => Get.back();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.loadingEmbedded.value = false;
      _controller.onInitParams(_params);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget body() => _body();

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return SizedBox(
        height: view.localWidgetSize?.height,
        width: view.localWidgetSize?.width,
        child: Obx(() {
          
          if (_controller.loadingEmbedded.value)
            return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Aguarde, preparando os dados.",
                  style: TextStyle(color: ConstColors.blue, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
              ],
            ),
          );
          print('idPaciente ${_controller.pacientId.value} UserId ${_controller.userId.value}');
          return WebViewApp(
            initialUrl: AppUrl.embeddedMemed(patientId: _controller.pacientId.value, userId: _controller.userId.value),
          );
        }),
      );
    });
  }
}
