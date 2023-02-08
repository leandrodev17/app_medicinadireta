import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_connecting.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/form/app_button_simple.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/infor_med/presenter/controller/infor_med_controller.dart';
import 'package:medicinadireta/modules/infor_med/presenter/widgets/informed_list_item.dart';
import 'package:medicinadireta/modules/infor_med/presenter/widgets/search_filter.dart';
import 'package:medicinadireta/modules/infor_med/presenter/widgets/shimmer_infor_med.dart';
import 'package:medicinadireta/modules/infor_med/presenter/widgets/title_filter.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class InforMedPhone extends StatefulWidget {
  const InforMedPhone({Key? key}) : super(key: key);

  @override
  _InforMedPhoneState createState() => _InforMedPhoneState();
}

class _InforMedPhoneState extends State<InforMedPhone> with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  final _controller = Get.find<InforMedController>();
  final _debouncer = Debouncer(delay: Duration(milliseconds: 800));
  var _searchEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchEC.clear();
      // _controller.filtroAbasUpdate(1);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _searchEC.dispose();
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width * .8,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _controller.listSortItem.length,
        itemBuilder: (BuildContext context, int index) {
          var _decode = _controller.listSortItem[index];
          return ListTile(
            title: Text(_decode['value'], style: Theme.of(context).textTheme.subtitle2),
            onTap: () => _controller.sortContentsInfoMed(_decode['id']),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () async => await Get.toNamed(Routes.MENU),
      appBar: AppBarDefault.bar(
        title: Image.asset(ConstDrawables.logoInformed, width: 120),
        backgroundColor: Color(0xff002d72),
        leadingColors: Colors.white,
        actions: [
          IconButton(
              onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Selecione o tipo de odenação que deseja.", style: Theme.of(context).textTheme.subtitle2),
                        content: setupAlertDialoadContainer(),
                        actions: [
                          AppButtonSimple(onPressed: () => Navigator.pop(context), backgroundColor: ConstColors.orange, child: Text("close".tr)),
                        ],
                      );
                    },
                  ),
              icon: Icon(Icons.sort_by_alpha_outlined, color: Colors.white))
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
      body: ResponsiveBuilder(builder: (context, view) {
        return CupertinoScrollbar(
          thumbVisibility: false,
          controller: _scrollController,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            controller: _scrollController,
            child: AnimatedFromColumn(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchFilter(controller: _controller, debouncer: _debouncer, searchEC: _searchEC),
                Container(
                  child: Obx(() {
                    return Wrap(
                      children: [
                        AppButtonSimple(
                          padding: EdgeInsets.all(10),
                          backgroundColor: _controller.filtroAbas.value == 1 ? ConstColors.orange : Color(0xff002d72),
                          onPressed: () async => await _controller.searchInfoMedFilterSpecialty(specialty: InforMedController.SPECIALTY_TODOS),
                          child: TitleFilter(title: InforMedController.SPECIALTY_TODOS),
                          width: 110,
                        ),
                        const SizedBox(width: 10),
                        AppButtonSimple(
                          padding: EdgeInsets.all(10),
                          onPressed: () async => await _controller.searchInfoMedFilterSpecialty(specialty: InforMedController.SPECIALTY_ADULTO),
                          backgroundColor: _controller.filtroAbas.value == 2 ? ConstColors.orange : Color(0xff002d72),
                          child: TitleFilter(title: InforMedController.SPECIALTY_ADULTO),
                          width: 110,
                        ),
                        const SizedBox(width: 10),
                        AppButtonSimple(
                          padding: EdgeInsets.all(6),
                          onPressed: () async => await _controller.searchInfoMedFilterSpecialty(specialty: InforMedController.SPECIALTY_PEDIATRIA),
                          backgroundColor: _controller.filtroAbas.value == 3 ? ConstColors.orange : Color(0xff002d72),
                          child: TitleFilter(title: InforMedController.SPECIALTY_PEDIATRIA),
                          width: 110,
                        ),
                      ],
                    );
                  }),
                ),
                Obx(() {
                  if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) return ShimmerInforMed();
                  if (_controller.isLoading.value == AppLoadingStatus.notConnecting) {
                    return Container(height: view.localWidgetSize?.height, child: AppNotConnecting());
                  }
                  if (_controller.isLoading.value == AppLoadingStatus.notLoading && _controller.resultSearchInforMed.isNotEmpty) {
                    return Container(padding: const EdgeInsets.symmetric(horizontal: 0), child: InforMedListItem(listData: _controller.resultSearchInforMed, controller: _controller));
                  }
                  return Container(
                    height: view.localWidgetSize?.height,
                    alignment: Alignment.center,
                    child: AppNotHasdata(
                      message: "Faça buscas por termos. Os últimos conteúdos acessados serão listados aqui",
                      visibleOnPressed: false,
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
