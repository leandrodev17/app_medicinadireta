import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeScreenExtension on num {
  double get wEx => ScreenUtil().setWidth(this);
  double get hEx => ScreenUtil().setHeight(this);
  double get rEx => ScreenUtil().radius(this);
  double get spEx => ScreenUtil().setSp(this);
  double get swEx => ScreenUtil().screenWidth * this;
  double get shEx => ScreenUtil().screenHeight * this;
  double get statusBarHeightEx => ScreenUtil().statusBarHeight * this;
}
