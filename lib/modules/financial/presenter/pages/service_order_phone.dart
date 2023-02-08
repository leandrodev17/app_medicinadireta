import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/financial/infra/models/service_order_ext.dart';
import 'package:medicinadireta/modules/financial/presenter/controller/service_order_controller.dart';
import 'package:medicinadireta/modules/financial/presenter/widgets/shimmer_service_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceOrderPhone extends StatefulWidget {
  final PatientModelExt model;
  ServiceOrderPhone({Key? key, required this.model}) : super(key: key);

  @override
  _ServiceOrderPhoneState createState() => _ServiceOrderPhoneState();
}

class _ServiceOrderPhoneState extends State<ServiceOrderPhone> with WidgetsBindingObserver {
  // final PatientModelExt _financial = Get.arguments;
  PatientModelExt get _financial => widget.model;
  final _controller = Get.find<ServiceOrderController>();
  final _scrollController = ScrollController();
  var visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getFirstPage(_financial.id);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      bottomNavigationBar: AppBottomNavigationBar(),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(
            titleApp: 'payment_order',
          ),
          body: ResponsiveBuilder(builder: (context, view) {
            return CupertinoScrollbar(
              thumbVisibility: false,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(3),
                controller: _scrollController,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: AnimatedFromColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                          if (_controller.listServiceOrder.isEmpty) {
                            return Container(
                              height: view.localWidgetSize!.height,
                              alignment: Alignment.center,
                              child: AppNotHasdata(loadData: () async => await _controller.getFirstPage(_financial.id)),
                            );
                          }
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.only(bottom: 12, top: 8),
                            child: ListView.separated(
                              itemBuilder: (_, index) {
                                final ServiceOrderExt _model = _controller.listServiceOrder[index];
                                var _statusOrder = _model.status != null ? _model.status?.nome.toString().toUpperCase() : '---';
                                return Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _financial.nome.toString(),
                                              style: Theme.of(context).textTheme.subtitle1,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(_statusOrder ?? '--'),
                                              Container(
                                                  width: 45,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                    color: ConstColors.orange,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      _financial.prontuario.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
                                                    ),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        color: ConstColors.ligtherGrey,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('total'.tr + ": ${_model.total.toString()}"),
                                            Text('paid'.tr + ": ${_model.pago.toString()}"),
                                            Text('balance'.tr + ": ${_model.saldo.toString()}")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: _controller.listServiceOrder.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (_, index) => Divider(),
                            ),
                          );
                        } else {
                          if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                            return ShimmerServiceOrder();
                          } else {
                            return Container(child: CupertinoActivityIndicator());
                          }
                        }
                      }),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
