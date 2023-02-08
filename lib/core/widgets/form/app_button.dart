import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final EdgeInsets? edgeInsets;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Color? colorBackground;
  final double? elevation;
  final double? minWidth;
  final double? height;
  final Function()? onPressed;
  final Widget childRaisedButton;

  const AppButton(
      {Key? key,
      this.edgeInsets,
      this.borderRadius,
      this.colorBackground,
      this.elevation,
      this.minWidth,
      this.height,
      this.onPressed,
      required this.childRaisedButton,
      this.borderSide = BorderSide.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.0,
      width: minWidth ?? 150.0,
      child: ButtonTheme(
        shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(4.0), side: borderSide!),
        padding: edgeInsets ?? EdgeInsets.all(20),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minWidth: minWidth ?? 0.0,
        height: height ?? 0.0,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(colorBackground ?? ConstColors.blue),
            elevation: MaterialStateProperty.all(elevation ?? 0),
            textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.button)
          ),
          onPressed: onPressed,
          child: childRaisedButton,
        ),
      ),
    );
  }
}
