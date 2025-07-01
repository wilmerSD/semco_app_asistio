import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/ui/components/btn_primary_ink.dart';
import 'package:semco_app_asistio/app/ui/components/field_form.dart';
import 'package:semco_app_asistio/app/ui/views/login/login_controller.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ya que se está utilizando Provider, no necesitas definirlo de nuevo aquí.
    final logincontroller = Provider.of<LoginController>(context);
    Widget imageLogo = Row(
      spacing: 5.0,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Power by',
          style: AppTextStyle(context).bold14(
            color: AppColors.quaternaryConst,
            fontWeight: FontWeight.w300,
          ),
        ),
        Container(
          width: 90,
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
    );
    Widget password = FieldForm(
      label: "Contraseña",
      hintText: "Ingresa tu contraseña",
      privateText: logincontroller.toggleVisibility,
      suffix: GestureDetector(
        onTap: () {
          logincontroller.seePassword();
        },
        child: IconButton(
          onPressed: () {
            logincontroller.seePassword();
          },
          icon: Icon(
            logincontroller.toggleVisibility
                ? Icons.visibility
                : Icons.visibility_off,
          ),
        ),
      ),
      textEditingController: logincontroller.ctrlPasswordText,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget user = FieldForm(
      label: "Usuario",
      hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: logincontroller.ctrlUserText,
    );

    Widget rememberPass = InkWell(
      onTap: () => logincontroller.checkRememberPass(),
      child: Row(
        children: [
          Checkbox(
            activeColor: AppColors.primary(context),
            value: logincontroller.rememberPass,
            onChanged: (_) {
              logincontroller.checkRememberPass();
            },
          ),
          Text(
            "Recordar datos",
            style: AppTextStyle(context).bold14(
              color: AppColors.quaternaryConst,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );

    Widget forgotPassword = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Olvidaste tu contraseña?',
          style: AppTextStyle(context).bold14(color: AppColors.quaternaryConst),
        ),
        InkWell(
          onTap: () {
            logincontroller.goToRecoverPass(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Recuperar aquí',
              //textScaler: 1,
              style: AppTextStyle(
                context,
              ).bold14(color: AppColors.primary(context)),
            ),
          ),
        ),
      ],
    );

    Widget button = BtnPrimaryInk(
      loading: logincontroller.isLoading,
      text: logincontroller.isLoading ? 'Validando' : "Ingresar",
      onTap: () => logincontroller.validateForm(context),
    );

    Widget footer = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            logincontroller.goToWhatsapp();
          },
          child: Row(
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/whatsaapLogo.png',
                    ), // Reemplaza con tu imagen
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Text(
                "¿Necesitas ayuda?",
                style: TextStyle(
                  color: AppColors.blueDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),

        Text(
          "Version 1.0.0",
          style: TextStyle(
            color: AppColors.grayBlue,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
      ],
    );

    Widget tittle = RichText(
      text: TextSpan(
        text: 'Asist',
        style: AppTextStyle(
          context,
        ).bold43(color: AppColors.quaternaryConst, fontWeight: FontWeight.w300),
        children: <TextSpan>[
          TextSpan(
            text: 'io',
            style: AppTextStyle(context).bold43(
              color: AppColors.primary(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    double widthScreen = MediaQuery.of(context).size.width;
    double? width;
    if (widthScreen < 600) {
      // width = 400;//Móvil
    } else if (widthScreen < 1000) {
      width = 400; //tablet
    } else {
      width = 600;// Layout para escritorio
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      body: ChangeNotifierProvider(
        create: (_) => LoginController(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Center(
              child: Container(
                width: 400,
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor(context),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grayBlue.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Título
                    tittle,
                    SizedBox(height: 30.0),
                    // Usuario
                    user,
                    SizedBox(height: 30.0),
                    // Contraseña
                    password,
                    SizedBox(height: 20.0),
                    rememberPass,
                    SizedBox(height: 10.0),
                    forgotPassword,
                    SizedBox(height: 20.0),
                    //Boton
                    button,
                    SizedBox(height: 30.0),
                    imageLogo,
                    // footer,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* 
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ya que se está utilizando Provider, no necesitas definirlo de nuevo aquí.
    final logincontroller = Provider.of<LoginController>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            // Título
            Text(
              'Gestión de pagos CIP - Lambayeque',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
} */
