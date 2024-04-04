import 'package:flutter/material.dart';
import 'custom_textstyles.dart';
import 'gen/colors.gen.dart';

class CustomAppBar{
  static customAppBar(BuildContext context,{
    required String appBarTitle,
    bool isArrowVisible=true,
    bool isAddVisible=false,
    void Function()? onTapArrow,
    void Function()? onTapAdd}){
    return AppBar(
        centerTitle: true,
        backgroundColor: ColorName.greyColor,
        title: Text(appBarTitle,style: CustomTextStyles.textStyle30(context)),
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isArrowVisible ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: GestureDetector(
                  onTap: onTapArrow,
                  child: const Icon(Icons.arrow_back,size: 40,color: ColorName.whiteColor,))) : const SizedBox.shrink(),
          isAddVisible ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: GestureDetector(
                  onTap: onTapAdd,
                  child: const Icon(Icons.add,size: 40,color: ColorName.whiteColor,))) : const SizedBox.shrink(),
      ],
    ),
    );
  }
}