import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberRecordPatient extends StatelessWidget {
  final String title;
  final String info;
  final Color color;

  const NumberRecordPatient({
    required this.title,
    required this.info,
    this.color = ConstColors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(this.title.toUpperCase()),
        TextButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ConstColors.orange),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 5)),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            minimumSize: MaterialStateProperty.all(Size(48, 24)),
          ),
          child: Text(this.info, style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
class NumberRecordPatient2 extends StatelessWidget {
  final String title;
  final String info;
  final Color color;

  const NumberRecordPatient2({
    required this.title,
    required this.info,
    this.color = ConstColors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(this.title,style: Theme.of(context).textTheme.subtitle2?.copyWith(color: ConstColors.blue, fontWeight: FontWeight.w400,fontSize: 14.sp)),
        TextButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ConstColors.orange),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 5.h)),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
            minimumSize: MaterialStateProperty.all(Size(48.w, 24.h)),
          ),
          child: Text(this.info, style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14.sp)),
        ),
      ],
    );
  }
}
