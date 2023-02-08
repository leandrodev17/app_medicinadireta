import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:get/get.dart';

class UpdateVersionAppController extends GetxController {
  forceUpdateToPlatform() async {
    if (GetPlatform.isAndroid) {
      await Helpers.launchURLOpenLink(Routes.URL_GOOGLE_PLAY);
      return;
    } else {
      await Helpers.launchURLOpenLink(Routes.URL_APPLE_STORE);
      return;
    }
  }
}
