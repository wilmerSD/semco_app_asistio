import 'package:flutter/material.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class Recomendations extends StatelessWidget {
  const Recomendations({super.key});

  @override
  Widget build(BuildContext context) {
    //final homecontroller = Provider.of<HomeController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            text: '* ',
            style: AppTextStyle(context).bold15(color: AppColors.textQuaternaryBasic(context), fontWeight: FontWeight.w400),
            children: <TextSpan>[
              TextSpan(
                text: 'Es obligatorio',
                style: AppTextStyle(context).bold15(
                  color: AppColors.primary(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    ' mantener la cámara encendida y conectada durante el proceso de registro de asistencia.',
                style: AppTextStyle(context).bold15(color: AppColors.textQuaternaryBasic(context), fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: '* ',
            style: AppTextStyle(context).bold15(color: AppColors.textQuaternaryBasic(context), fontWeight: FontWeight.w400),
            children: <TextSpan>[
              TextSpan(
                text: 'Para validar tu asistencia, presiona el botón',
                style: AppTextStyle(context).bold15(color: AppColors.textQuaternaryBasic(context), fontWeight: FontWeight.w400)
              ),
              TextSpan(
                text: ' "Tomar Foto".',
                style: AppTextStyle(context).bold15(
                  color: AppColors.primary(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: '* ',
            style:AppTextStyle(context).bold15(
                  color: AppColors.primary(context),
                  fontWeight: FontWeight.bold,
                ),
            children: <TextSpan>[
              TextSpan(
                text: 'La fotografía ',
                style:AppTextStyle(context).bold15(
                  color: AppColors.primary(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    ' debe ser clara, tomada de frente, con la cabeza centrada y recta, manteniendo una expresión neutral, con los ojos abiertos y la boca cerrada. No se permiten gafas de sol, sombreros o cualquier accesorio que oculte el rostro, y la imagen debe incluir la parte superior del cuerpo, desde el pecho hacia arriba.',
                style: AppTextStyle(context).bold15(color: AppColors.textQuaternaryBasic(context), fontWeight: FontWeight.w400)
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: '* ',
            style: AppTextStyle(context).bold15(color: AppColors.textQuaternaryBasic(context), fontWeight: FontWeight.w400),
            children: <TextSpan>[
              TextSpan(
                text:
                    'Si la foto capturada no es adecuada, tienes la opción de ',
                style: AppTextStyle(context).bold15(color: AppColors.textQuaternaryBasic(context), fontWeight: FontWeight.w400)
              ),
              TextSpan(
                text: 'volver a capturar ',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.primary(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    'la imagen tantas veces como sea necesario antes de enviar tu asistencia definitiva. Una vez satisfecho con la foto, envíala junto con tu información de asistencia.',
                style: AppTextStyle(context).bold15(color: AppColors.textQuaternaryBasic(context), fontWeight: FontWeight.w400)
              ),
            ],
          ),
        ),
      ],
    );
  }
}
