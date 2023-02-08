import 'dart:io';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/dom.dart' as dom;
import 'package:photo_view/photo_view.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';

// https://app.informed.digital/auth?auth=NC1tZWRpY2luYWRpcmV0YS1QRVA=&user=OTYwNw==&cpf=MTI5NzI1NjUwNjE=
class AppHtml extends StatelessWidget {
  final String? onData;
  final TextStyle? textStyle;

  AppHtml({Key? key, this.onData, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = textStyle != null ? Style.fromTextStyle(textStyle!) : Style.fromTextStyle(GoogleFonts.openSans(fontSize: 14.spEx, fontWeight: FontWeight.w400, color: ConstColors.cinza));
    if (onData == null || onData == '') return Container();
    return Html(
      data: onData,
      style: {
        "tr": _style,
        "th": _style,
        "td": _style,
        'h5': _style,
        "p": _style,
        "p > a": Style(textDecoration: TextDecoration.none),
      },
      tagsList: Html.tags..remove(Platform.isAndroid ? "iframe" : "video"),
      onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) => url != null || url != '' ? Helpers.launchURLOpenLink(url ?? '') : null,
      onImageTap: (String? image, RenderContext context, Map<String, String> attributes, dom.Element? element) {},
      customImageRenders: {
        networkSourceMatcher(): networkImageRender(
          headers: {"Custom-Header": "some-value"},
          altWidget: (alt) => Text(alt ?? ""),
          loadingWidget: () => const Text("Loading..."),
        ),
        (attr, _) => attr["src"] != null && attr["src"]!.isNotEmpty: networkImageRender(mapUrl: (url) => url!),
      },
      customRender: {
        "img": (RenderContext context, Widget child) {
          return Container(
              padding: const EdgeInsets.all(17),
              height: 200,
              alignment: Alignment.center,
              child: PhotoView(
                backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                imageProvider: NetworkImage(context.tree.attributes['src'].toString(), scale: 1),
                loadingBuilder: (BuildContext context, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return Container();
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                    ),
                  );
                },
              ));
        },
        "gif": (RenderContext context, Widget child) {
          return Container(
              padding: const EdgeInsets.all(17),
              height: 200,
              alignment: Alignment.center,
              child: PhotoView(
                backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                imageProvider: NetworkImage(context.tree.attributes['src'].toString(), scale: 1),
              ));
        },
      },
      onImageError: (exception, stackTrace) {},
    );
  }
}
