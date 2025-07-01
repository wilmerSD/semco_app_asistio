import 'package:flutter/material.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class AlertDialogComp extends StatelessWidget {
  final String headerTitle;
  final Widget widgetContent;

  const AlertDialogComp({
    Key? key,
    required this.headerTitle,
    required this.widgetContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:AppColors.backgroundColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Personaliza el radio
      ),
      title: Text(
        headerTitle,
        style:AppTextStyle(context).bold17(color: AppColors.textQuaternaryBasic(context), fontWeight: FontWeight.bold),        
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.all(15.0),
      content: widgetContent,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Entendido',
            style: AppTextStyle(context).bold15(
              color: AppColors.textQuaternaryBasic(context),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
