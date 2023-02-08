import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:flutter/material.dart';

class ModeloListSliverExemplo extends StatelessWidget {
  const ModeloListSliverExemplo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, view) {
      return RefreshIndicator(
        onRefresh: () => Future.value(true),
        child: CustomScrollView(
          // controller: _scrollController,
          slivers: [
            // Obx(() {
            //   if (_controller.isLoading.value == AppLoadingStatus.notConnecting) {
            //     return SliverToBoxAdapter(
            //       child: Container(
            //         height: view.localWidgetSize!.height,
            //         alignment: Alignment.center,
            //         child: AppNotHasdata(loadData: () async => await _controller.swipeRefresh(pacientId: _params.pacienteId)),
            //       ),
            //     );
            //   }
            //   if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
            //     if (_controller.listItensAllergys.isEmpty) {
            //       return SliverToBoxAdapter(
            //         child: Container(
            //           height: view.localWidgetSize!.height,
            //           alignment: Alignment.center,
            //           child: AppNotHasdata(loadData: () async => await _controller.swipeRefresh(pacientId: _params.pacienteId)),
            //         ),
            //       );
            //     }
            //     return SliverList(
            //       delegate: SliverChildBuilderDelegate(
            //         (context, index) {
            //           final Allergy _model = _controller.listItensAllergys[index];
            //           return Text(_model.profissional!.nome.toString());
            //         },
            //         childCount: _controller.listItensAllergys.length,
            //       ),
            //     );
            //   } else {
            //     if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
            //       return const SliverToBoxAdapter(child: ShimmerAllergy());
            //     } else {
            //       return const SliverToBoxAdapter(child: CupertinoActivityIndicator());
            //     }
            //   }
            // }),
          ],
        ),
      );
    });
  }
}
