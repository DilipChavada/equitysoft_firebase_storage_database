import 'package:equitysoft_add_update_delete_view_data_local_storage_database/custom_textstyles.dart';
import 'package:flutter/material.dart';

import 'gen/colors.gen.dart';

class CustomTextField{
  static customTextField(
      BuildContext context,{
        required TextEditingController? controller,
        required String? hintText,
    required String? labelText,
    required TextInputType? keyboardType,
        int? maxLines = 1,
        String? Function(String?)? validator,
        bool readOnly = false,
        bool enableInteractiveSelection=true,
   }){
    return TextFormField(
      style: CustomTextStyles.textStyle16(context).copyWith(color:readOnly ? ColorName.greyColor : ColorName.blackColor),
      enableInteractiveSelection: enableInteractiveSelection,
      readOnly: readOnly,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(5)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorName.blackColor,
            ),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: readOnly ? ColorName.greyColor.withOpacity(0.20): ColorName.blackColor,
            ),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(color: readOnly ? ColorName.greyColor.withOpacity(0.20) : ColorName.blackColor,
            ),
            borderRadius: BorderRadius.circular(5)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: readOnly ? ColorName.greyColor.withOpacity(0.20): ColorName.blackColor,
            ),borderRadius: BorderRadius.circular(5)),
        hintText: hintText,
        labelStyle: CustomTextStyles.textStyle14(context).copyWith(
            color:readOnly ? ColorName.greyColor : ColorName.blackColor),
        labelText: labelText,
      ),
    );
  }
}