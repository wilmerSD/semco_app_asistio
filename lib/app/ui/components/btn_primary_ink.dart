import 'package:flutter/material.dart';
import 'package:semco_app_asistio/core/helpers/constant.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class BtnPrimaryInk extends StatelessWidget {
  const BtnPrimaryInk({
    super.key,
    required this.text,
    this.loading = false,
    this.onTap,
    this.isGreen = false,
    this.margin,
    this.showBoxShadow = true,
  });
  final String text;
  final bool loading;
  final bool? isGreen;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool showBoxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      margin: margin,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(kRadiusSmall),
        boxShadow:
            showBoxShadow
                ? [
                  BoxShadow(
                    color: const Color.fromARGB(66, 247, 191, 118),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ]
                : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: loading ? null : onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textScaler: TextScaler.linear(1),
                  text,
                  style: AppTextStyle(context).bold18(color: Colors.white),
                ),
                loading
                    ? const Row(
                      children: [
                        SizedBox(width: 30.0),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ],
                    )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
