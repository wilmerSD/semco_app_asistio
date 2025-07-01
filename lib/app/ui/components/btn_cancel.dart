
import 'package:flutter/material.dart';
import 'package:semco_app_asistio/core/helpers/constant.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class BtnCancel extends StatelessWidget {
  const BtnCancel(
      {Key? key,
      required this.text,
      this.onTap,
      this.borderColor,
      this.textColor})
      : super(key: key);
  final String text;
  final void Function()? onTap;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(kRadiusMedium),
          border: Border.all(color: borderColor ?? AppColors.primary(context), width: 2)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: const Color.fromRGBO(0, 0, 0, 0.08),
          borderRadius: BorderRadius.circular(10.5),
          onTap: onTap,
          child: Center(
            child: Text(text,
                style: AppTextStyle(context).bold18(color: AppColors.primary(context))),
          ),
        ),
      ),
    );
  }
}
