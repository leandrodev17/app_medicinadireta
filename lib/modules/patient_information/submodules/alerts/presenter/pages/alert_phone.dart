import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_html.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/patient_information/presenter/controller/patient_datails_controller.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertPhone extends StatefulWidget {
  AlertPhone({Key? key}) : super(key: key);

  @override
  _AlertPhoneState createState() => _AlertPhoneState();
}

class _AlertPhoneState extends State<AlertPhone> with WidgetsBindingObserver {
  final _controller = Get.find<PatientDetailsController>();

  final _scrollController = ScrollController();
  ParamsToNavigationPage _params = Get.arguments;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      appBar: AppBarDefault.bar(
        title: Text('alertas'.tr.toUpperCase()),
        onPressedLeading: () async => await Get.toNamed(Routes.PATIENT_DETAILS, arguments: _params),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AppBottomNavigationBar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 70),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add, size: 24, color: Colors.white),
          backgroundColor: ConstColors.blue,
        ),
      ),
      body: ResponsiveBuilder(builder: (context, view) {
        return RefreshIndicator(
          onRefresh: () => Future.value(true),
          child: CupertinoScrollbar(
            thumbVisibility: false,
            controller: _scrollController,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              controller: _scrollController,
              child: AnimatedFromColumn(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() {
                    return ListView.separated(
                      itemBuilder: (_, index) {
                        var _model = _controller.alerts[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1.0, color: ConstColors.border),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            leading: Icon(Icons.lock_outlined),
                            title: Text(_model.titulo1.toString(), style: Theme.of(context).textTheme.subtitle1),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID: ${_model.titulo2.toString()}', style: Theme.of(context).textTheme.subtitle2),
                                Text('Num. Atend: ${_model.titulo3.toString()}', style: Theme.of(context).textTheme.subtitle2),
                              ],
                            ),
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Divider(),
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.border_color_outlined),
                                    label: Text('edit'.tr, style: Theme.of(context).textTheme.subtitle2),
                                  ),
                                  Divider(),
                                ],
                              ),
                              ItensAnamnese(title: "--", subTitle: "---"),
                            ],
                          ),
                        );
                      },
                      itemCount: _controller.alerts.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (_, index) => Divider(),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ItensAnamnese extends StatelessWidget {
  final String? title;
  final String? subTitle;

  ItensAnamnese({Key? key, this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: subTitle?.isNotEmpty ?? false,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Color(0xFFF5f5f5)),
            ),
            child: AppHtml(onData: "<b>$title</b></br> <span>$subTitle</span"),
          ),
        ],
      ),
    );
  }
}
