import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNotAccessPhone extends StatefulWidget {
  final String title;
  PageNotAccessPhone({Key? key, this.title = 'Medicina Direta'}) : super(key: key);

  @override
  _PageNotAccessPhoneState createState() => _PageNotAccessPhoneState();
}

class _PageNotAccessPhoneState extends State<PageNotAccessPhone> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarDefault.bar(title: Text(widget.title.tr.toUpperCase())),
       bottomNavigationBar: AppBottomNavigationBar(),
      body: ResponsiveBuilder(builder: (context, view) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: AnimatedFromColumn(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(ConstDrawables.access, width: 250)),
                Text(
                  'Você não tem permissão para acessar esta área.',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: ConstColors.orange, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10,),
                Text(
                  'Caso necessário, solicite ao administrador de sua unidade de saúde esta permissão de acesso.',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: ConstColors.blue, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
