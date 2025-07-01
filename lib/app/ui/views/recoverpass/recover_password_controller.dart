import 'package:flutter/material.dart';
import 'package:semco_app_asistio/app/provider/user_provider.dart';
import 'package:semco_app_asistio/app/ui/views/login/login_view.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/widgets/recover_pass_code.dart';
import 'package:semco_app_asistio/app/ui/views/recoverpass/widgets/recover_pass_reset.dart';
import 'package:semco_app_asistio/core/helpers/custom_snackbar.dart';

class RecoverPassController with ChangeNotifier {
  final UserProvider userProvider = UserProvider();
  bool _isVisiblePass = false;
  bool _isLoading = false;
  bool _isVisiblePassRepeat = false;

  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();
  TextEditingController ctrlPasswordToConfirm = TextEditingController();
  TextEditingController ctrlCodeVerification = TextEditingController();
  TextEditingController ctrlUser = TextEditingController();

  String codeGenerate = '';
  String personalId = '';

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  set isVisiblePass(bool value) {
    _isVisiblePass = value;
    notifyListeners();
  }
  set isVisiblePassRepeat(bool value) {
    _isVisiblePassRepeat = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isVisiblePass => _isVisiblePass;
  bool get isVisiblePassRepeat => _isVisiblePassRepeat;

  Future validateEmail(BuildContext context) async {
    isLoading = true;
    try {
      final response = await userProvider.postSendEmail(ctrlEmail.text);
      if (!response.success!) {
        CustomSnackbar.showSnackBarSuccess(
          context,
          title: "Validar!",
          message: response.data ?? '',
          type: 2,
          time: 2,
        );
        return;
      }
      codeGenerate = response.data ?? '';
      personalId = response.statusMessage ?? '';
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RecoverPassCode()),
      );
    } catch (e) {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message:
            'Ups! Ocurrió un error inesperado, intente nuevamente${e.toString()}',
        type: 1,
        time: 2,
      );
    } finally {
      isLoading = false;
    }
  }

  Future validateCode(BuildContext context) async {
    try {
      isLoading = true;
      final response = await userProvider.postVerificationCode(
        ctrlCodeVerification.text,
        codeGenerate,
      );
      if (!response.success!) {
        CustomSnackbar.showSnackBarSuccess(
          context,
          title: "Validar!",
          message: response.data ?? '',
          type: 2,
          time: 2,
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RecoverPassReset()),
      );
    } catch (e) {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message:
            'Ups! Ocurrió un error inesperado, intente nuevamente${e.toString()}',
        type: 1,
        time: 2,
      );
    } finally {
      isLoading = false;
    }
  }


  Future validatePass(BuildContext context) async {
    try {
      isLoading = true;
      final response = await userProvider.postChangePassword(
        ctrlPassword.text,
        ctrlPasswordToConfirm.text,
        personalId,
      );
      if (!response.success!) {
        CustomSnackbar.showSnackBarSuccess(
          context,
          title: "Validar!",
          message: response.data ?? '',
          type: 2,
          time: 2,
        );
        return;
      }
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Información!",
        message: response.data ?? '',
        type: 3,
        time: 3,
      );
      goToLogin(context);
    } catch (e) {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message:
            'Ups! Ocurrió un error inesperado, intente nuevamente${e.toString()}',
        type: 1,
        time: 2,
      );
    } finally {
      isLoading = false;
    }
  }

  /* 📌 Regresar a login */
  void goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }
}
