import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AppDraggableScrollableSheet extends StatefulWidget {
  final List<Widget> children;
  final Function()? onTap;
  const AppDraggableScrollableSheet({
    Key? key,
    this.children = const <Widget>[],
    this.onTap,
  }) : super(key: key);

  @override
  State<AppDraggableScrollableSheet> createState() => _AppDraggableScrollableSheetState();
}

class _AppDraggableScrollableSheetState extends State<AppDraggableScrollableSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          padding: const EdgeInsets.all(10),
          child: ListView(
            controller: controller,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}




class AppShowModalBottomSheet {
  AppShowModalBottomSheet._();

  static appShowModalBottomSheet(
    Widget widget, {
    Color? backgroundColor,
    bool isScrollControlled = true,
    bool isDismissible = false,
    bool enableDrag = false,
  }) {
    return showModalBottomSheet(
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor ?? Colors.transparent,
      // backgroundColor: ConstColors.backgroundModal.withOpacity(.8),
      context: Get.context!,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      builder: (context) => widget,
    );
  }
}
