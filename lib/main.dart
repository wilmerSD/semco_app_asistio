import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semco_app_asistio/app/provider/user_provider.dart';
import 'package:semco_app_asistio/app/ui/views/home/home_controller.dart';
import 'package:semco_app_asistio/app/ui/views/login/login_controller.dart';
import 'package:semco_app_asistio/app/ui/views/myprofile/myprofile_controller.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/recover_password_controller.dart';
import 'package:semco_app_asistio/app/ui/views/splash/splash_controller.dart';
import 'package:semco_app_asistio/app/ui/views/splash/splash_view.dart';
import 'package:semco_app_asistio/core/config/app_config.dart';
import 'package:semco_app_asistio/core/config/theme_app.dart';
import 'package:semco_app_asistio/core/network/dio_client.dart';
import 'package:semco_app_asistio/core/network/dio_config.dart';
import 'package:semco_app_asistio/core/preferences/shared_preferences.dart';
import 'package:semco_app_asistio/core/preferences/theme_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

late DioClient dioClient; // Variable global
void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Necesario para inicializar dependencias antes de runApp()
  await PreferencesUser.init();
  AppConfig.initialize();
  // Inicializar localización
  await PreferencesUser.init();
  await initializeDateFormatting("ES", null);
  final dio = await DioConfig.initialize();
  dioClient = DioClient(dio); // Inicializar DioClient globalmente

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => RecoverPassController()),
        ChangeNotifierProvider(create: (_) => MyprofileController()),
        ChangeNotifierProvider(create: (_) => SplashController()),
        // Otros controladores

        ChangeNotifierProvider(create: (_) => ThemeProvider(darkMode: PreferencesUser().themeBool)),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider(),),

        Provider<Dio>(create: (_) => dio),
        Provider<DioClient>(create: (_) => dioClient),
        
      ],
    child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asistencia',
      theme: ThemeApp(
                darkMode:
                    Provider.of<ThemeProvider>(context, listen: true).themeDark).getTheme(),
      home: const SplashView(),
    );
  }
}
