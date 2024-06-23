import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'custom_textstyles.dart';
import 'gen/colors.gen.dart';

class CustomDropDownTextField {
  static customDropDownTextField(BuildContext context,{
    required List<DropDownValueModel> dropDownList,
    required String? hintText,
    required String? labelText,
    String? Function(String?)? validator,
    dynamic controller,
    void Function(dynamic)? onChanged,
    bool isEnabled = true,
  }) {
    return DropDownTextField(
      listTextStyle: CustomTextStyles.textStyle16(context).copyWith(color:isEnabled ? ColorName.blackColor : ColorName.greyColor),
      textStyle: CustomTextStyles.textStyle16(context).copyWith(color:isEnabled ? ColorName.blackColor : ColorName.greyColor ),
      isEnabled: isEnabled,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
        textFieldDecoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: CustomTextStyles.textStyle14(context).copyWith(
              color:isEnabled ? ColorName.blackColor : ColorName.greyColor),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorName.blackColor,
              ),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isEnabled ? ColorName.blackColor : ColorName.greyColor,
              ),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isEnabled ? ColorName.blackColor : ColorName.greyColor,
              ),
             borderRadius: BorderRadius.circular(5)
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: isEnabled ? ColorName.blackColor : ColorName.greyColor,
              ),
              borderRadius: BorderRadius.circular(5)),
        ),
      dropDownList: dropDownList,
    );
  }
}
