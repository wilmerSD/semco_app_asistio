import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/ui/components/alert/cupertino_alert_dialog_comp.dart';
import 'package:semco_app_asistio/app/ui/components/alert_dialog_component.dart';
import 'package:semco_app_asistio/app/ui/views/home/home_provider.dart';
import 'package:semco_app_asistio/app/ui/views/login/login_provider.dart';
import 'package:semco_app_asistio/core/helpers/constant.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class DrawerMenuApp extends StatelessWidget {
  const DrawerMenuApp({super.key});

  @override
  Widget build(BuildContext context) {

    final homecontroller = Provider.of<HomeProvider>(context, listen: false);
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeController =
          Provider.of<HomeProvider>(context, listen: false);
      final loginController = Provider.of<LoginProvider>(context, listen: false);
     homeController.getPhotoProfile(loginController.imgPerson);
    });
  
    bool whatPlatformIs = false;

    if (!kIsWeb) {
      whatPlatformIs = Platform.isIOS;
    } else {}
    print('hola drawer');
    
    Widget buildProfileImage(BuildContext context, String base64String) {
      Widget defaultAvatar() {
        return CircleAvatar(
          backgroundColor: AppColors.primary(context),
          radius: kRadiusLarge,
          child: Icon(
            Icons.person,
            color: AppColors.backgroundColor(context),
            size: kIconSize,
          ),
        );
      }

      if (base64String.isEmpty) return defaultAvatar();

      try {
        final bytes = base64Decode(base64String);
        return CircleAvatar(
          backgroundImage: MemoryImage(bytes),
          radius: kRadiusLarge,
        );
      } catch (_) {
        return defaultAvatar();
      }
    }

    return Drawer(
      // width: 100,
      backgroundColor: AppColors.backgroundColor(context),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Consumer<HomeController>(
            //   builder: (context, homeController, child) {
            //     print('😊${homeController.imgPerson}');
            //     return buildProfileImage(context, homeController.imgPerson);
            //   },
            // ),
            Consumer<LoginProvider>(
              builder: (context, loginController, child) {
                print('😊${loginController.imgPerson}'); 
                return buildProfileImage(context, '');
              },
            ),
            // buildProfileImage(context, loginController.imgPerson),
            // CircleAvatar(
            //   backgroundColor: AppColors.primary(context),
            //   radius: kRadiusLarge,
            //   child: Icon(
            //     Icons.person,
            //     color: AppColors.backgroundColor(context),
            //     size: kIconSize,
            //   ),
            // ),
            SizedBox(height: kSize),
            Text(
              "Hola,",
              style: AppTextStyle(
                context,
              ).medium14(color: AppColors.quaternaryConst),
            ),
            Text(
              "José Wilmer Sanchez Díaz",
              style: AppTextStyle(
                context,
              ).bold18(color: AppColors.quaternaryConst),
            ),
            SizedBox(height: kSize),
            const Divider(color: AppColors.grayLight),
            customLisTile(
              context,
              'Perfil',
              Bootstrap.person_gear,
              () => homecontroller.goToProfile(context),
            ),
            /* SizedBox(height: kSize.h), */
            /*  const Divider(color: AppColors.grayLight),
            ListTile(
              onTap: () => (),
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.receipt,
                size: kIconSizeSmall.h,
                color: AppColors.blueDark,
              ),
              title: Text(
                "Registro de solicitudes",
                style: AppTextStyle(context).medium14(
                  color: AppColors.blueDark,
                ),
              ),
            ), */
            /*  const Divider(color: AppColors.grayLight),
            ListTile(
              onTap: () => {},
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.security,
                size: kIconSizeSmall.h,
                color: AppColors.blueDark,
              ),
              title: Text(
                "Cambiar contraseña",
                style: AppTextStyle(context).medium14(
                  color: AppColors.blueDark,
                ),
              ),
            ), */
            const Spacer(),
            customLisTile(context, 'Cerrra sesión', Icons.logout, () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return whatPlatformIs
                      ? CupertinoAlertDialogComp(
                        tittle: "¿Seguro que quieres salir de Asistio?",
                        content: Text(""),
                        onTapButton: () {
                          homecontroller.goToLogin(context);
                        },
                      )
                      : AlertDialogComponent(
                        onTapButton: () => {homecontroller.goToLogin(context)},
                        title: "¿Seguro que quieres salir de Asistio?",
                      );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget customLisTile(
  BuildContext context,
  String text,
  IconData icon,
  Function()? onTap,
) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: kPaddingAppLargeApp),
    onTap: onTap,
    // contentPadding: EdgeInsets.zero,
    leading: Icon(icon, size: kIconSizeSmall, color: AppColors.quaternaryConst),
    title: Text(
      text,
      style: AppTextStyle(context).medium14(color: AppColors.quaternaryConst),
    ),
  );
}
