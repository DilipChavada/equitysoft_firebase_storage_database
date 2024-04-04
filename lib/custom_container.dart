import 'package:equitysoft_add_update_delete_view_data_local_storage_database/custom_textstyles.dart';
import 'package:flutter/material.dart';

import 'gen/colors.gen.dart';

class CustomContainer{
    static Widget customContainer(BuildContext context,{
      String? text,
      void Function()? onTap,
      double? height,
      double? width,
      TextStyle? textStyle,
      Widget? child,
    }){
      return GestureDetector(
      onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height:height ?? MediaQuery.of(context).size.height*0.33,
          width:width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:ColorName.greyColor,
          ),
          child : child ?? Text(text ?? "",style:textStyle ?? CustomTextStyles.textStyle22(context)),
        ),
      );
    }
}