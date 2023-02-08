import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarDefault {
  AppBarDefault._();

  static AppBar bar({
    Key? key,
    Widget? leading,
    Function()? onPressedLeading,
    Color? leadingColors,
    bool showIconBackTop = true,
    bool automaticallyImplyLeading = true,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    Color? shadowColor,
    ShapeBorder? shape,
    Color? backgroundColor,
    Color? foregroundColor,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    bool primary = true,
    bool? centerTitle,
    bool excludeHeaderSemantics = false,
    double? titleSpacing,
    double toolbarOpacity = 1.0,
    double bottomOpacity = 1.0,
    double? toolbarHeight,
    double? leadingWidth,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    SystemUiOverlayStyle? systemOverlayStyle,
    double? leadingSizeIcon = 24,
    String? titleApp = '--',
    IconData? backIcon,
    // bool? backwardsCompatibility,
    // Brightness? brightness,
  }) {
    return AppBar(
      key: key,
      actions: actions,
      actionsIconTheme: actionsIconTheme,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      bottom: bottom,
      bottomOpacity: bottomOpacity,
      centerTitle: centerTitle,
      elevation: elevation,
      excludeHeaderSemantics: excludeHeaderSemantics,
      flexibleSpace: flexibleSpace,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      leading: showIconBackTop
          ? (leading ??
              IconButton(
                  icon: Icon(
                    backIcon ?? ConstDrawables.appIconBack,
                    color: leadingColors ?? ConstColors.blue,
                    size: leadingSizeIcon,
                  ),
                  onPressed: onPressedLeading ?? () => Get.back()))
          : IconButton(icon: Container(), onPressed: null),
      leadingWidth: leadingWidth,
      primary: primary,
      shadowColor: shadowColor,
      shape: shape,
      systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
      title: title ??
          Text(
            titleApp!.tr,
            style: GoogleFonts.openSans(
              color: ConstColors.graphite,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
      titleSpacing: titleSpacing ?? 0,
      titleTextStyle: titleTextStyle,
      toolbarHeight: toolbarHeight,
      toolbarOpacity: toolbarOpacity,
      toolbarTextStyle: toolbarTextStyle,
      // backwardsCompatibility: backwardsCompatibility,
      // brightness: brightness,
      // textTheme: textTheme,
    );
  }
}
