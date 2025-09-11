import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/ui/components/alert/cupertino_alert_dialog_comp.dart';
import 'package:semco_app_asistio/app/ui/components/alert_dialog_component.dart';
import 'package:semco_app_asistio/app/ui/components/leading_appbar.dart';
import 'package:semco_app_asistio/app/ui/views/home/home_provider.dart';
import 'package:semco_app_asistio/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:semco_app_asistio/core/preferences/shared_preferences.dart';
import 'package:semco_app_asistio/core/preferences/theme_provider.dart';
import 'package:semco_app_asistio/core/routes/app_routes_name.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class MyprofileView extends StatelessWidget {
  const MyprofileView({super.key});

  @override
  Widget build(BuildContext context) {
    final myprofilecontroller = Provider.of<MyprofileProvider>(context);
    final prefs = PreferencesUser();
    bool whatPlatformIs = false;

    if (!kIsWeb) {
      whatPlatformIs = Platform.isIOS;
    } else {}

    Widget profilePhoto = Column(
      spacing: 5.0,
      children: [
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor:
                    myprofilecontroller.profileImage != null
                        ? AppColors.primaryConst
                        : const Color.fromARGB(
                          29,
                          254,
                          144,
                          0,
                        ), //const Color.fromARGB(255, 207, 207, 207),
                radius: 80,
                backgroundImage:
                    myprofilecontroller.profileImage != null
                        ? FileImage(myprofilecontroller.profileImage!)
                        : null,
                child:
                    myprofilecontroller.profileImage != null
                        ? const SizedBox()
                        : const Icon(
                          Icons.person,
                          size: 80,
                          color: Color.fromARGB(113, 254, 144, 0),
                        ),
              ),
              /*  Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () => myprofilecontroller.pickImageFromGallery(),
                  child: const Icon(Iconsax.edit_outline),
                ),
              )  */
              /* CircleAvatar(
                          backgroundColor: AppColors.blueCustom,
                          child: Icon(Iconsax.edit_outline, color: Colors.white,))) */
            ],
          ),
        ),
        // Center(
        //     child: loginController.responsedata.personalNombres != null
        //         ? Text(
        //             '${loginController.responsedata.personalNombres} ${loginController.responsedata.personalApellidos}',
        //             style: AppTextStyle(context)
        //                 .bold16(color: AppColors.textBasic(context)))
        //         : Text(splashController.names + splashController.lastName))
      ],
    );

    Widget darkMode = _customContainer(
      context,
      SizedBox(
        width: 25,
        child: Transform.scale(
          scale: 0.5,
          child: Switch(
            value: prefs.themeBool,
            onChanged: (_) {
              bool value = prefs.themeBool;
              prefs.themeBool = !value;
              Provider.of<ThemeProvider>(context, listen: false).getValueTheme =
                  !value;
            },
          ),
        ),
      ),
      'Modo oscuro',
      () {
        bool value = prefs.themeBool;
        prefs.themeBool = !value;
        Provider.of<ThemeProvider>(context, listen: false).getValueTheme =
            !value;
      },
      prefs.themeBool ? Icons.dark_mode_outlined : Icons.light_mode,
    );

    Widget closeSesion = _customContainer(
      context,
      const Icon(Bootstrap.door_open),
      "Cerrar Sesión",
      () {
        if (whatPlatformIs) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialogComp(
                tittle: '¿Seguro que quieres salir de Asistio?',
                onTapButton: () {
                  context.read<HomeProvider>().goToLogin(context);
                  // context.go(AppRoutesName.LOGIN);
                },
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialogComponent(
                onTapButton: () {
                  context.read<HomeProvider>().goToLogin(context);
                  // context.go(AppRoutesName.LOGIN);
                },

                title: "¿Seguro que quieres salir de Asistio?",
              );
            },
          );
        }
      },
      Icons.arrow_forward_ios,
    );

    Widget helpWidget = _customContainer(
      context,
      const Icon(Bootstrap.life_preserver),
      "Ayuda",
      () {},
      Icons.arrow_forward_ios,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.primary(context),
        leading: const LeadingAppbar(),
        title: Text(
          "Perfil",
          style: AppTextStyle(
            context,
          ).bold20(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                spacing: 20.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [profilePhoto],
              ),
            ),
            Column(
              spacing: 10.0,
              children: [darkMode /* ,helpWidget */, closeSesion],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _customContainer(
  BuildContext context,
  Widget icon,
  String text,
  VoidCallback ontap,
  IconData iconRight,
) {
  return InkWell(
    onTap: ontap,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0 /*  vertical: 20.0 */,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(92, 249, 249, 250),
        border: Border.all(color: const Color.fromRGBO(232, 242, 250, 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 10.0,
            children: [
              icon,
              Text(
                text,
                style: AppTextStyle(context).bold16(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBasic(context),
                ),
              ),
            ],
          ),
          Icon(iconRight),
        ],
      ),
    ),
  );
}
