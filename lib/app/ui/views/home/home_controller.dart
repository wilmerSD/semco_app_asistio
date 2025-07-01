import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:typed_data";
import "package:confetti/confetti.dart";
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:intl/intl.dart";
import "package:intl/intl_standalone.dart";
import "package:semco_app_asistio/app/models/request/request_saveassistant_model.dart";
import "package:semco_app_asistio/app/models/response/response_inforassistant_model.dart";
import "package:semco_app_asistio/app/provider/user_provider.dart";
import "package:semco_app_asistio/app/repository/user_repository.dart";
import "package:semco_app_asistio/app/ui/views/home/home_view.dart";
import "package:semco_app_asistio/app/ui/views/home/widgets/camera_screen.dart";
import "package:semco_app_asistio/app/ui/views/login/login_view.dart";
import "package:semco_app_asistio/app/ui/views/myprofile/myprofile_view.dart";
import "package:semco_app_asistio/core/helpers/custom_snackbar.dart";

class HomeController with ChangeNotifier {
  //Instance
  final UserRepository userRepository = UserRepository();
  final UserProvider userProvider = UserProvider();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  //Variables

  var now = DateTime.now();
  late Timer timer;

  var formatterDate = DateFormat('dd/MM/yy');
  var formatterTime = DateFormat('kk:mm');
  var monthName = DateFormat('MMMM', 'es');
  

  File? imageFile;
  void updateImageFile(File pImageFile) {
    imageFile = pImageFile;
    notifyListeners();
  }

  Uint8List? imageBytes;
  void updateImageBytes(Uint8List bytes) {
    imageBytes = bytes;
    notifyListeners(); // si estás usando Provider o similar
  }

  String dayNumber = '';
  String dayName = '';
  String personalId = '';
  String _currentTime = '';
  String get currentTime => _currentTime; // Obtiene la hora formateada
  String pathOfImage = '';
  String imgPerson = '';

  TextEditingController ctrlComment = TextEditingController(text: '');

  bool isCentered = false;
  bool isPlayingConfetti = false;
  bool isRegisteredAssist = false;

  //Functions
  Future<void> initialize() async {
    await getInfoUser();
  }

  Future<void> getInfoUser() async {
    personalId = await secureStorage.read(key: 'kIdUser') ?? '';
    notifyListeners();
  }

  timeProvider() {
    _currentTime = _getCurrentTime();
    _startTimer();
    notifyListeners();
  }

  // Función para obtener la hora actual
  String _getCurrentTime() {
    return DateFormat('HH:mm:ss').format(DateTime.now());
  }

  void animatedInit() {
    Future.delayed(const Duration(seconds: 2), () => isCentered = !isCentered);
  }

  List<DataInfoAssistant> dataInfoAssistant = [];
  DataInfoAssistant infoAssistObject = DataInfoAssistant();

  // Inicia el temporizador y actualiza la hora cada segundo
  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime = _getCurrentTime();
      notifyListeners(); // Notifica a los listeners para que se reconstruyan
    });
  }

  final confettiController = ConfettiController();
  void activateConffeti() {
    isPlayingConfetti = !isPlayingConfetti;
    confettiController.play();
    notifyListeners();
    // if (isPlayingConfetti) {
    //   confettiController.play();
    // } else {
    //   confettiController.stop();
    // }
    print("activando confeti");
    Future.delayed(
      Duration(milliseconds: 200),
      () => confettiController.stop(),
    );
    notifyListeners();
  }

  //traer información del usuario
  Future<void> getInfoAssistant() async {
    try {
      final response = await userRepository.getInfoAssistant(personalId);
      if (!response.success) {
        return;
      }
      dataInfoAssistant = response.data ?? [];
      infoAssistObject = dataInfoAssistant[0];
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }

  String asisstandId = '';
  Future<void> postRegisterAssist(context) async {
    isRegisteredAssist = true;
    try {
      // if (imageFile != null) await postSaveImage(imageFile!);
      if (imageBytes != null) await postSaveImageBytes(imageBytes!);
      if (pathOfImage.isEmpty) {
        CustomSnackbar.showSnackBarSuccess(
          context,
          title: "Validar!",
          message:
              "Ocurrio un error, subiendo la imagen, por favor intente nuevamente",
          type: 1,
          time: 2,
        );
        return;
      }
      final response = await userProvider.postSaveAssistant(
        RequestSaveassistantModel(
          pAsistenciaid: infoAssistObject.asistenciaId,
          pPersonalId: personalId,
          pTipo: infoAssistObject.asistenciaTipo ?? '',
          pComentario: ctrlComment.text,
          pTextFoto: pathOfImage,
        ),
      );
      if (response.ppAsistenciaid.isEmpty) {
        CustomSnackbar.showSnackBarSuccess(
          context,
          title: "Validar!",
          message:
              "Ocurrio un error, tratando de registrar su asistencia, por favor intente nuevamente",
          type: 1,
          time: 2,
        );
        return;
      }
      asisstandId = response.ppAsistenciaid;
      ctrlComment.text = '';
      String textToShow =
          "Su registro de ${infoAssistObject.asistenciaTipoDescription} ha sido guardado exitosamente.";
      String textToFinalize =
          '¡Felicidades! Has completado todas tus asistencias de hoy.';

      if (infoAssistObject.asistenciaTipo == 'AS') {
        textToShow = textToShow + '\n' + textToFinalize;
      }

      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Información!",
        message: textToShow,
        type: 3,
        time: 5,
      );
      activateConffeti();
      getInfoAssistant();
    } catch (e) {
    } finally {
      isRegisteredAssist = false;
      imageFile = null;
      imageBytes = null;
      notifyListeners();
    }
  }

  Future<void> postSaveImage(File pFile) async {
    try {
      final response = await userProvider.postSaveImage(pFile);
      Map<String, dynamic> responseData = json.decode(response);

      // Extraer el `path`
      if (responseData.isEmpty) {
        return;
      }

      if (responseData.containsKey("files") && responseData["files"] is List) {
        pathOfImage = responseData["files"][0]["path"];
      }
    } catch (e) {
      print("Error: wilmer" + e.toString());
    } finally {
      // isRegisteredAssist = false;
      notifyListeners();
    }
  }

  Future<void> postSaveImageBytes(Uint8List bytes) async {
    try {
      final response = await userProvider.postSaveImageBytes(bytes);
      if (response.objectId!.isEmpty) {
        return;
      }
      pathOfImage = response.objectId ?? '';
    } catch (e) {
      print("Error: wilmer" + e.toString());
    } finally {
      notifyListeners();
    }
  }

 

  /* 📌 Obtener fecha y hora */
  Future<String> getFormattedDate() async {
    formatterDate = DateFormat('dd/MM/yy');
    return formatterDate.format(now);
  }

  Future<void> initializeLocalization() async {
    await findSystemLocale(); // Esto carga la configuración local automáticamente
  }

  String getMontName() {
    return monthName.format(now);
  }

  String getDayNumber() {
    dayNumber = DateFormat('d').format(now); // Ejemplo: "21"
    return dayNumber;
  }

  String getDayName() {
    dayName = DateFormat('EEEE', 'es').format(now); // Ejemplo: "martes"
    return dayName;
  }

  /* 📌 Regresar a login */
  void goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  void goToCamera(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CameraScreen()),
    );
  }

  void goToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyprofileView()),
    );
  }

  void goToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }
}
