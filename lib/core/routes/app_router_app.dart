import 'package:go_router/go_router.dart';
import 'package:semco_app_asistio/app/ui/views/home/home_view.dart';
import 'package:semco_app_asistio/app/ui/views/login/login_view.dart';
import 'package:semco_app_asistio/app/ui/views/myprofile/myprofile_view.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/recover_password_view.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/widgets/recover_pass_code.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/widgets/recover_pass_email.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/widgets/recover_pass_reset.dart';
import 'package:semco_app_asistio/app/ui/views/splash/splash_view.dart';
import 'package:semco_app_asistio/core/routes/app_routes_name.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashView()),
    GoRoute(
      path: AppRoutesName.LOGIN,
      builder: (context, state) => LoginView(),
    ),
    GoRoute(path: AppRoutesName.HOME, builder: (context, state) => HomeView()),
    GoRoute(
      path: AppRoutesName.PROFILE,
      builder: (context, state) => MyprofileView(),
    ),
    
    GoRoute(
      path: AppRoutesName.RECOVERPASS,
      builder: (context, state) => RecoverPasswordView(),
      routes: [
        GoRoute(
          path: AppRoutesName.PROFILE,
          builder: (context, state) => RecoverPasswordEmail(),
        ),
        GoRoute(
          path: AppRoutesName.PROFILE,
          builder: (context, state) => RecoverPassCode(),
        ),
        GoRoute(
          path: AppRoutesName.PROFILE,
          builder: (context, state) => RecoverPassReset(),
        ),
      ],
    ),
  ],
);
  // static const SPLASH = "/splash";
  // static const LOGIN = "/login";
  // static const HOME = "/home";
  // static const PROFILE = "/profile";

  // static const RECOVERPASS = "/recoverpass";
  // static const RECOVERPASSEMAIL = "/recoverpass";
  // static const RECOVERPASSCODE = "/recoverpass";
  // static const RECOVERPASSNEW = "/recoverpass";