import "package:flutter/widgets.dart";
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:semco_app_asistio/app/models/request/request_login_model.dart";
import "package:semco_app_asistio/app/models/response/response_infopersonal_model.dart";
import "package:semco_app_asistio/app/repository/user_repository.dart";
import "package:semco_app_asistio/app/ui/views/home/home_view.dart";
import "package:semco_app_asistio/app/ui/views/recoverpass/widgets/recover_pass_email.dart";
import "package:semco_app_asistio/core/helpers/custom_snackbar.dart";
import "package:semco_app_asistio/core/helpers/keys.dart";
import "package:url_launcher/url_launcher.dart";

class LoginController with ChangeNotifier {
  
  int counter = 0;
  TextEditingController ctrlUserText = TextEditingController(text: 'Jose.sanchez');
  TextEditingController ctrlPasswordText = TextEditingController(text:'jsanchezSemco07');
  bool isVisibleIcon = false;
  bool isLoading = false;
  bool rememberPass = false;
  bool toggleVisibility = true;
  Datum responseData = Datum();
  bool isInitalized = false;

  String imgPerson = '';

  //INSTANCES
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final UserRepository userRepository = UserRepository();
  void onInit(){
    if(isInitalized) return;
    getUserAndPass();
  }

  /* 📌 Ir al home */
  void goToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()), // Reemplaza con tu pantalla Home
    );
  }
  void getUserAndPass() async{
    ctrlUserText.text = await secureStorage.read(key: "kUserName")?? '';
    ctrlPasswordText.text  = await secureStorage.read(key: "kPassword") ?? '';
  }
  /* 📌 Regresar a login */
  void goToRecoverPass(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RecoverPasswordEmail()), // Reemplaza con tu pantalla Home
    );
  }

   /* 📌 Regresar a login */
  void goToWhatsapp() async {
    const phoneNumber = '949238476'; // Número de teléfono con código de país
    const message = 'Hola, estoy interesado en tus servicios.'; // Mensaje predeterminado
    final url = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir WhatsApp';
    }
  }
  
  void validateForm(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (ctrlUserText.text.trim() == "" && ctrlPasswordText.text.trim() == "") {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message: "Por favor, ingrese su usuario y contraseña.",
        type: 1,
        time: 2,
      );
      return;
    }
     if (ctrlUserText.text.trim() == "") {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message: "Por favor, ingrese su usuario",
        type: 1,
        time: 2,
      );
    }
    if (ctrlPasswordText.text.trim() == "") {
       CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message: "Por favor, ingrese su contraseña",
        type: 1,
        time: 2,
      );
    }
    authentication(context);
  }
    
  void authentication(context) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await userRepository.postLogin(
        RequestLoginModel(
            pUsername:  ctrlUserText.text, pPassword: ctrlPasswordText.text));
      if (!response.success) {
        CustomSnackbar.showSnackBarSuccess(
          context,
          title: "Validar!",
          message: "Ups! Ocurrió un error, ${response.statusMessage}",
          type: 1,
          time: 2,
        );
        return;
      }
      responseData = response.data![0];
      imgPerson = responseData.personalPhoto ?? '';
      if(rememberPass) {
        await secureStorage.write(key: Keys.kUserName, value: ctrlUserText.text);
        await secureStorage.write(key: Keys.kPassword, value: ctrlPasswordText.text);
      }

      await secureStorage.write(key: Keys.kIdUser, value: responseData.personalId);
      await secureStorage.write(key: Keys.kIdRole, value: responseData.personalRol);
      await secureStorage.write(key: Keys.kNameUser, value: responseData.personalNombreCompleto);
      await secureStorage.write(key: Keys.kEmail, value: responseData.personalCorreo);
         notifyListeners();
        goToHome(context);
      }catch(e){
        CustomSnackbar.showSnackBarSuccess(
            context,
            title: "Validar!",
            message: "Ups! Ocurrió un error inesperado, intente nuevamente${e.toString()}",
            type: 1,
            time: 2,
          );
      }finally{
        isLoading = false;
        notifyListeners();
      }
  }

  void checkRememberPass(){
    rememberPass = !rememberPass;
     notifyListeners();
  }

    void seePassword(){
    toggleVisibility = !toggleVisibility;
    notifyListeners();
  }
}


