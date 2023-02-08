import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpansionItemTitle extends StatelessWidget {
  final String? title;
  final Color? colorItem;
  final bool openCard;

  const ExpansionItemTitle({Key? key, this.title, this.colorItem, this.openCard = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      height: 50.h,
      width: double.infinity,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(color: colorItem, borderRadius: BorderRadius.circular(5)),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 60.w,
            child: Text(
              title?.toUpperCase() ?? '--',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.sp),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.r), topLeft: Radius.circular(5.r)),
              ),
              width: 50.w,
              height: 50.h,
              child: Icon(Icons.warning_amber, size: 30.w, color: Colors.white),
            ),
          ),
          Positioned(
            right: 10,
            child: Icon(openCard ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 30.h, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
