import 'package:flutter/material.dart';

class AppButtonElevated extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final Color backgroundColor;
  final EdgeInsets padding;
  const AppButtonElevated({Key? key, required this.onPressed, required this.child, this.backgroundColor = Colors.white, this.padding = EdgeInsets.zero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.pressed) ? Colors.grey[100] : null,
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        elevation: MaterialStateProperty.all(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: MaterialStateProperty.all(padding),
      ),
      child: child,
    );
  }
}
