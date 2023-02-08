import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../themes/theme_service.dart';
import '../themes/themes.dart';

import 'core/binding_from_initial/application_binding.dart';
import 'core/shared/logger/logger_utils.dart';
import 'lang/translation_service.dart';
import 'routes/app_pages.dart';

class MyAppProd extends StatelessWidget {
  const MyAppProd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          initialBinding: ApplicationBinding(),
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.topLevel,
          enableLog: true,
          logWriterCallback: Logger.write,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
          supportedLocales: const [Locale("pt", "BR"), Locale("es", "ES"), Locale("en", "US")],
          title: 'Medicina Direta',
          theme: Themes().lightTheme,
          darkTheme: Themes().darkTheme,
          themeMode: ThemeService().getThemeMode(),
          builder: (BuildContext context, Widget? widget) {
            ScreenUtil.init(context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
        );
      },
    );
  }
}
