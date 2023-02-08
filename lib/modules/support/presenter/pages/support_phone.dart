import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class SupportPhone extends StatefulWidget {
  SupportPhone({Key? key}) : super(key: key);

  @override
  _SupportPhoneState createState() => _SupportPhoneState();
}

class _SupportPhoneState extends State<SupportPhone> with WidgetsBindingObserver {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      onWillPop: () async => await Future.value(true),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(titleApp: 'Suporte'),
          body: ResponsiveBuilder(builder: (context, view) {
            return RefreshIndicator(
              onRefresh: () async => await Future.value(true),
              child: CupertinoScrollbar(
                thumbVisibility: false,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(3),
                  controller: _scrollController,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: AnimatedFromColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 25),
                                Text(ConstStrings.titleSupport, style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(ConstStrings.textSupport, textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle2),
                                ),
                                const SizedBox(height: 32),
                                _item(icon: Icons.phone, title: "Tel.: ", subtitle: ConstStrings.contactPhone, onTap: () => Helpers.launchPhone(ConstStrings.contactPhone)),
                                const SizedBox(height: 15),
                                InkWell(
                                  onTap: () => Helpers.launchURLOpenLink(Helpers.urlWhatsApp('+551151844714', "Suporte Medicina Direta")),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(ConstDrawables.whatsapp, color: ConstColors.greenDark, fit: BoxFit.cover, height: 30),
                                      const SizedBox(width: 10),
                                      RichText(
                                        text: TextSpan(
                                          text: 'WhatsApp: ',
                                          style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(text: '55 11 ${ConstStrings.contactPhoneWhats}\n', style: Theme.of(context).textTheme.subtitle2),
                                            TextSpan(text: '(apenas mensagens de texto)', style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                _item(icon: Icons.email, subtitle: ConstStrings.contactEmail, onTap: () => Helpers.launchEmail("mailto:${ConstStrings.contactEmail}")),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  _item({IconData? icon, String subtitle = '', Function()? onTap, String title = '', String? helper}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: ConstColors.orange),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              text: title,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(text: subtitle, style: Theme.of(context).textTheme.subtitle2),
                TextSpan(text: helper != null ? helper : null, style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
