import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_html.dart';
import 'package:medicinadireta/core/widgets/app_not_connecting.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/contents_info_med.dart';
import 'package:medicinadireta/modules/infor_med/presenter/controller/infor_med_controller.dart';
import 'package:medicinadireta/modules/infor_med/presenter/widgets/shimmer_infor_med.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ContentsHtml extends StatefulWidget {
  final String id;
  final InforMedController controller;
  ContentsHtml({Key? key, required this.id, required this.controller}) : super(key: key);

  @override
  State<ContentsHtml> createState() => _ContentsHtmlState();
}

class _ContentsHtmlState extends State<ContentsHtml> with WidgetsBindingObserver {
  final _scrollController = ScrollController();

  InforMedController get _controller => widget.controller;
  String get _id => widget.id;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.searchContentsIDInfoMed(_id);
    });
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault.bar(title: Text('Visualização do Contéudo.'.tr)),
      bottomNavigationBar: AppBottomNavigationBar(),
      body: ResponsiveBuilder(builder: (context, view) {
        return CupertinoScrollbar(
          controller: _scrollController,
          thumbVisibility: false,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            controller: _scrollController,
            child: AnimatedFromColumn(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  if (_controller.isLoadingSearchContentsId.value == AppLoadingStatus.shimmerLoading) return ShimmerInforMed();
                  if (_controller.isLoadingSearchContentsId.value == AppLoadingStatus.notConnecting) {
                    return Container(height: view.localWidgetSize?.height, child: AppNotConnecting());
                  }
                  if (_controller.isLoadingSearchContentsId.value == AppLoadingStatus.notLoading && _controller.resultSearchContentsIDInforMed.isNotEmpty) {
                    var _onData = "--";
                    ContentsInfoMed _model = _controller.resultSearchContentsIDInforMed.first;
                    if (_model.tipo == "tabela")
                      _onData = _model.descricao ?? '--';
                    else if (_model.tipo == "figura")
                      _onData = _model.descricao ?? '--';
                    else
                      _onData = _model.conteudoHtml ?? '--';

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          AppHtml(onData: _onData),
                          Visibility(
                            visible: _model.url != null && _model.tipo == "tabela" || _model.tipo == "figura",
                            child: Container(
                              height: 200,
                              alignment: Alignment.center,
                              child: PhotoView(
                                backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                                imageProvider: NetworkImage(_model.url.toString().trim()),
                                loadingBuilder: (BuildContext context, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return Container();
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container(
                    height: view.localWidgetSize?.height,
                    alignment: Alignment.center,
                    child: AppNotHasdata(
                      message: "Não foi possível visualizar o conteúdo!",
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
