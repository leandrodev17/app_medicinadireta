import 'package:flutter/material.dart';

class TitleFilter extends StatelessWidget {
  final String? title;
  const TitleFilter({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) => Text(title ?? '--',
      style: Theme.of(context).textTheme.subtitle2?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 14
          ),
      textAlign: TextAlign.center);
}
