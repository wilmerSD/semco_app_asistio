import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/ui/components/btn_primary_ink.dart';
import 'package:semco_app_asistio/app/ui/components/field_form.dart';
import 'package:semco_app_asistio/app/ui/views/login/login_provider.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Hola Login');
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Builder(
        builder: (context) {
          debugPrint('Hola Login2');
          Future.microtask(() {
            context.read<LoginProvider>().onInit(); // Solo una vez
          });
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.backgroundColor(context),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Center(
                  child: Container(
                    width: 400,
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 30.0,
                    ),
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
                        _tittle(context),
                        const SizedBox(height: 30.0),
                        _user(context),
                        const SizedBox(height: 30.0),
                        _password(),
                        const SizedBox(height: 20.0),
                        rememberPass(context),
                        _forgotPassword(context),
                        const SizedBox(height: 20.0),
                        _button(),
                        const SizedBox(height: 30.0),
                        _imageLogo(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tittle(BuildContext context) {
    return RichText(
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
  }

  Widget _user(BuildContext context) {
    debugPrint('Hola usuario');
    return FieldForm(
      label: "Usuario",
      hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: context.read<LoginProvider>().ctrlUserText,
    );
  }

  // Widget _password(BuildContext context) {
  Widget _password() {
    debugPrint('Hola password');
    return Selector<LoginProvider, bool>(
      selector: (_, provider) => provider.toggleVisibility,
      builder: (context, toggleVisibility, _) {
        final provider = context.read<LoginProvider>();
        return FieldForm(
          label: "Contraseña",
          hintText: "Ingresa tu contraseña",
          privateText: toggleVisibility,
          suffix: IconButton(
            onPressed: provider.seePassword,
            icon: Icon(
              toggleVisibility ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          textEditingController: provider.ctrlPasswordText,
        );
      },
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Olvidaste tu contraseña?',
          style: AppTextStyle(context).bold14(color: AppColors.quaternaryConst),
        ),
        InkWell(
          onTap: () => context.read<LoginProvider>().goToRecoverPass(context),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Recuperar aquí',
              style: AppTextStyle(
                context,
              ).bold14(color: AppColors.primary(context)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _button() {
    return Selector<LoginProvider, bool>(
      selector: (_, provider) => provider.isLoading,
      builder: (context, isLoading, _) {
        return BtnPrimaryInk(
          loading: isLoading,
          text: isLoading ? 'Validando' : "Ingresar",
          onTap: () => context.read<LoginProvider>().validateForm(context),
        );
      },
    );
  }

  Widget _imageLogo(BuildContext context) {
    return Row(
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
            image: DecorationImage(
              image: AssetImage('assets/semcocadLogo.png'),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ],
    );
  }
}

Widget rememberPass(BuildContext context) {
  return Selector<LoginProvider, bool>(
    selector: (_, provider) => provider.rememberPass,
    builder: (context, rememberPass, child) {
      print('Hola remember pass');
      return Row(
        children: [
          Checkbox(
            activeColor: AppColors.primary(context),
            value: rememberPass,
            onChanged: (_) {
              context.read<LoginProvider>().checkRememberPass();
            },
          ),
          child!, // reutilizamos el texto sin redibujarlo
        ],
      );
    },
    child: Text(
      "Recordar datos",
      style: AppTextStyle(context).bold14(
        color: AppColors.quaternaryConst,
        fontWeight: FontWeight.w300,
      ),
    ),
  );
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
