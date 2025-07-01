import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semco_app_asistio/core/helpers/constant.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class FieldForm extends StatelessWidget {
  const FieldForm(
      {super.key,
      required this.label,
      this.hintText = "",
      this.privateText = false,
      this.suffix,
      this.onChanged,
      this.onEditingComplete,
      this.initialValue = "",
      this.enabledfield = false,
      this.textCapitalization,
      this.maxlines = 1,
      this.textEditingController,
      this.textInputType = TextInputType.text,
      this.autofocus = false,
      this.maxLength,
      this.inputFormats});
  final String label;
  final String hintText;
  final bool privateText;
  final Widget? suffix;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final String? initialValue;
  final bool? enabledfield;
  final TextCapitalization? textCapitalization;
  final int? maxlines;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final bool? autofocus;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormats;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: true,
      inputFormatters: inputFormats,
      autofocus: autofocus ?? false,
      keyboardType: textInputType,
      maxLines: maxlines,
      readOnly: enabledfield!,
      controller: textEditingController,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      maxLength: maxLength,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      style: AppTextStyle(context).semi14(color: AppColors.primary(context)),
      obscureText: privateText,
      decoration: InputDecoration(
        counterText: "",
        filled: false,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 20.0,
        ),
        //floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: suffix,
        suffixIconColor: AppColors.primary(context),
        floatingLabelStyle: AppTextStyle(context).medium14(
          color: AppColors.grayBlue,
        ),
        labelStyle: AppTextStyle(context).medium14(
          color: AppColors.grayBlue,
        ),
        hintText: hintText,
        hintStyle: AppTextStyle(context).medium14(
          color: AppColors.black,
        ),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusMedium),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusSmall),
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColors.grayLight,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusMedium),
          borderSide: BorderSide(
            width: .5,
            color: AppColors.primary(context),
          ),
        ),
      ),
    );
  }
}
