import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:flutter/material.dart';

class CardExpansion extends StatelessWidget {
  final Widget? body;
  final Widget title;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const CardExpansion({Key? key, this.body, required this.title, this.backgroundColor, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          title,
          // Visibility(visible: body != null, child: body!),
        ],
      ),
    );
  }
}
