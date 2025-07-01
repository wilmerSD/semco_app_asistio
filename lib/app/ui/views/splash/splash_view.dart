import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/ui/views/login/login_controller.dart';
import 'package:semco_app_asistio/app/ui/views/login/login_view.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simula una espera antes de redirigir a la vista de inicio de sesión
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => LoginController(),
            child: const LoginView(),
          ),
        ),
      );
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          //gradient: AppColors.gradientToLogin
        ),
        child: Center(
          child: FadeIn(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Asist',
                    style: AppTextStyle(context).bold43(color: AppColors.quaternaryConst,fontWeight: FontWeight.w300),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'io',
                        style: AppTextStyle(context).bold43(color: AppColors.primary(context), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  spacing: 5.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Power by', style: AppTextStyle(context).bold16(color: const Color.fromARGB(255, 90, 90, 90), fontWeight: FontWeight.w300 ),),
                    Container(
                      width: 100,
                      height: 30,
                      decoration: const BoxDecoration(
                        // color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/semcocadLogo.png',
                          ), // Reemplaza con tu imagen
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
