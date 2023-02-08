import 'dart:io';

import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhoto extends StatefulWidget {
  final File file;
  ViewPhoto({required this.file, Key? key}) : super(key: key);

  @override
  _ViewPhotoState createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          'view_file'.tr,
          // style: Theme.of(context).appBarTheme.textTheme!.headline6!.copyWith(fontSize: 20),
        ),
      ),
      body: ResponsiveBuilder(builder: (context, view) {
        return Container(
          padding: const EdgeInsets.all(17),
          height: view.localWidgetSize?.height,
          width: view.localWidgetSize?.width,
          alignment: Alignment.center,
          child: widget.file.path != ''
              ? PhotoView(
                  imageProvider: FileImage(widget.file),
                  backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                )
              : Container(
                  height: view.localWidgetSize!.height,
                  alignment: Alignment.center,
                  child: AppNotHasdata(
                    message: "not_found_image".tr,
                    visibleOnPressed: false,
                  ),
                ),
        );
      }),
    );
  }
}
