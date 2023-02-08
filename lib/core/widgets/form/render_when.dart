import 'package:flutter/material.dart';

class RenderWhen extends StatelessWidget {
  final String text;
  final Color color;
  final bool isLoading;
  final bool isLockeding;
  final TextStyle? textStyleButton;
  RenderWhen({this.isLoading = false, this.isLockeding = false, required this.text, this.textStyleButton, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    Widget _circularProgressIndicator = Container(child: CircularProgressIndicator(strokeWidth: 1, color: Colors.white), height: 18.0, width: 18.0);

    Widget _text = Text(text, style: textStyleButton ?? Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w500, color: color));

    Widget _locked = isLockeding ? Container(margin: const EdgeInsets.symmetric(horizontal: 10), child: Icon(Icons.lock, size: 18, color: Colors.white)) : Container();

    Widget textButton = Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [_text, _locked]);

    return this.isLoading ? _circularProgressIndicator : textButton;
  }
}
