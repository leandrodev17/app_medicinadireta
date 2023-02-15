import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/item_submenu_model.dart';

class ItemMenu extends StatelessWidget {
  final String titlePrimary;
  final bool showItem;
  final bool visiblePrimary;
  final bool visibleIconLeading;
  final List<ItemSubmenuModel> itens;
  final Widget? leadingPrimary;
  final Function()? onTapPrimary;
  final EdgeInsets? contentPadding;
  final Color trailingColorPrimary;
  final Color backgroundItem;
  final Color colorIconLeading;
  final Color colorTextLeading;
  final String? iconDataImage;
  final EdgeInsets contentPaddingSub;
  final TextStyle? styleTitlePrimary;

  const ItemMenu({
    Key? key,
    this.titlePrimary = '',
    this.leadingPrimary,
    this.onTapPrimary,
    this.iconDataImage,
    this.showItem = false,
    this.visiblePrimary = true,
    this.visibleIconLeading = true,
    this.itens = const [],
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.trailingColorPrimary = ConstColors.cinza,
    this.colorIconLeading = ConstColors.cinza,
    this.colorTextLeading = ConstColors.blue,
    this.backgroundItem = ConstColors.white,
    this.contentPaddingSub = EdgeInsets.zero,
    this.styleTitlePrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visiblePrimary,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.0, color: const Color(0xFFCACBD7)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: backgroundItem,
              padding: contentPadding,
              alignment: Alignment.centerLeft,
              // height: 50.h,
              child: ListTile(
                onTap: onTapPrimary,
                contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                title: Text(
                  titlePrimary,
                  style: styleTitlePrimary ??
                      GoogleFonts.openSans(
                        color: ConstColors.blue,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                  // style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700, color: ConstColors.blue),
                ),
                leading: Visibility(
                  visible: visibleIconLeading,
                  child: iconDataImage != null ? Image.asset(iconDataImage!, width: 25) : (leadingPrimary ?? Container()),
                ),
                trailing: Icon(itens.isNotEmpty ? (showItem ? ConstDrawables.appIconArrowUp : ConstDrawables.appIconArrowDown) : ConstDrawables.appIconArrowRight, size: 25.w, color: trailingColorPrimary),
              ),
            ),
            Visibility(visible: showItem, child: const Divider(color: ConstColors.borderItemMenu, endIndent: 15, height: 2, indent: 15, thickness: 0.6)),
            AnimatedOpacity(
              opacity: showItem ? 1.0 : 0.0,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 500),
              child: Visibility(
                visible: showItem,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.0, color: Colors.white),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)),
                  ),
                  padding: const EdgeInsets.only(right: 10, left: 40),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, indexItem) {
                      ItemSubmenuModel dataSub = itens[indexItem];
                      return Visibility(
                        visible: dataSub.visible,
                        child: Container(
                          padding: contentPaddingSub,
                          // height: 45,
                          child: InkWell(
                            onTap: dataSub.onTap,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: dataSub.iconDataImage != null ? Image.asset(dataSub.iconDataImage!, width: 25.w) : null,
                              title: Text(
                                dataSub.title.toString(),
                                style: GoogleFonts.openSans(color: ConstColors.cinza, fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              trailing: Icon(ConstDrawables.appIconArrowRight, size: 25.w, color: ConstColors.cinza),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, indexItem) => Container(color: const Color(0xFFCACBD7), height: 0.4),
                    itemCount: itens.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemMenuItemMenu extends StatelessWidget {
  final String titlePrimary;
  final bool showItem;
  final bool visiblePrimary;
  final bool visibleIconLeading;
  final List<ItemSubmenuModel> itens;
  final Widget? leadingPrimary;
  final Function()? onTapPrimary;
  final EdgeInsets? contentPadding;
  final Color trailingColorPrimary;
  final Color backgroundItem;
  final Color colorIconLeading;
  final Color colorTextLeading;
  final String? iconDataImage;
  final List<Widget> itemMenu;

  const ItemMenuItemMenu({
    Key? key,
    this.titlePrimary = '',
    this.leadingPrimary,
    this.onTapPrimary,
    this.iconDataImage,
    this.showItem = false,
    this.visiblePrimary = true,
    this.visibleIconLeading = true,
    this.itens = const [],
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.trailingColorPrimary = ConstColors.blue,
    this.colorIconLeading = ConstColors.blue,
    this.colorTextLeading = ConstColors.blue,
    this.backgroundItem = ConstColors.white,
    required this.itemMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visiblePrimary,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.0, color: const Color(0xFFCACBD7)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: backgroundItem,
              padding: contentPadding,
              alignment: Alignment.centerLeft,
              height: 40.h,
              child: ListTile(
                onTap: onTapPrimary,
                contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                title: Text(titlePrimary, style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700, color: ConstColors.blue)),
                leading: Visibility(
                  visible: visibleIconLeading,
                  child: iconDataImage != null ? Image.asset(iconDataImage!, width: 25) : (leadingPrimary ?? Container()),
                ),
                trailing: Icon((showItem ? ConstDrawables.appIconArrowUp : ConstDrawables.appIconArrowDown), size: 25.w, color: trailingColorPrimary),
              ),
            ),
            Visibility(visible: showItem, child: const Divider(color: ConstColors.borderItemMenu, endIndent: 15, height: 2, indent: 15, thickness: 0.6)),
            AnimatedOpacity(
              opacity: showItem ? 1.0 : 0.0,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 500),
              child: Visibility(
                visible: showItem,
                // child: itemMenu,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) => itemMenu[i],
                  separatorBuilder: (context, indexItem) => showItem ? Container() : Container(color: const Color(0xFFCACBD7), height: 0.4),
                  itemCount: itemMenu.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
