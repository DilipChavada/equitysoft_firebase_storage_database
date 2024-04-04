import 'package:flutter/material.dart';

import 'gen/colors.gen.dart';

class CustomTextStyles{
  static const double fontSize9=9;
  static const double fontSize10=10;
  static const double fontSize14=14;
  static const double fontSize16=16;
  static const double fontSize18=18;
  static const double fontSize20=20;
  static const double fontSize22=22;
  static const double fontSize30=30;

  static TextStyle? commonTextStyle(BuildContext context){
    return Theme.of(context).textTheme.bodyMedium;
  }
  static TextStyle textStyle9(BuildContext context){
    return commonTextStyle(context)!.copyWith(fontSize: fontSize9,color:ColorName.greyColor,fontWeight: FontWeight.w400);
  }
  static TextStyle textStyle10(BuildContext context){
    return commonTextStyle(context)!.copyWith(fontSize: fontSize10,color:ColorName.greyColor,fontWeight: FontWeight.w400);
  }
  static TextStyle textStyle14(BuildContext context){
    return commonTextStyle(context)!.copyWith(fontSize: fontSize14,color:ColorName.greyColor,fontWeight: FontWeight.w400);
  }
  static TextStyle textStyle22(BuildContext context){
    return commonTextStyle(context)!.copyWith(fontSize: fontSize22,color:ColorName.whiteColor,fontWeight: FontWeight.w400);
  }
  static TextStyle textStyle20(BuildContext context){
    return commonTextStyle(context)!.copyWith(fontSize: fontSize20,color:ColorName.whiteColor,fontWeight: FontWeight.w400);
  }
  static TextStyle textStyle16(BuildContext context){
    return commonTextStyle(context)!.copyWith(fontSize: fontSize16,color:ColorName.blackColor);
  }
  static TextStyle textStyle18(BuildContext context){
    return commonTextStyle(context)!.copyWith(fontSize: fontSize18,color:ColorName.blackColor);
  }
  static TextStyle textStyle30(BuildContext context){
    return commonTextStyle(context)!.copyWith(fontSize: fontSize30,color:ColorName.whiteColor,fontWeight: FontWeight.w500);
  }
}