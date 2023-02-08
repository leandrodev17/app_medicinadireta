import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medicinadireta/modules/logs/pages/view_logs.dart';

import '../themes/theme_service.dart';
import '../themes/themes.dart';

import 'core/binding_from_initial/application_binding.dart';
import 'core/shared/logger/logger_utils.dart';
import 'lang/translation_service.dart';
import 'routes/app_pages.dart';

class MyAppDebug extends StatelessWidget {
  const MyAppDebug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              GetMaterialApp(
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
              ),
              Positioned(
                right: 100,
                top: 40,
                child: Align(
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.blue.withOpacity(0.25),
                    onPressed: () => Get.to(() => const ViewLogs()),
                    child: Icon(Icons.build, color: Colors.white.withOpacity(0.25)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
