import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semco_app_asistio/core/helpers/constant.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';
import 'package:semco_app_asistio/core/theme/app_text_style.dart';

class Helpers {
  static Future<dynamic> loadJsonAssets(String fileName) async {
    final response = await rootBundle.loadString("assets/json/$fileName");
    return json.decode(response);
  }

  static DateTime stringToDateTime(String dateTimeString) {
    try {
      final formatter = DateFormat('yyyy/MM/dd');
      return formatter.parse(dateTimeString);
    } catch (e) {
      return DateTime.now();
    }
  }

  static noRequiredDateTime(String? value, String date) {
    RegExp fechaRegex =
        RegExp(r'^(\d{4})/(0[1-9]|1[0-2])/(0[1-9]|1\d|2\d|3[01])$');
    if (value == null || value.isEmpty) {
      return null;
    } else if (!fechaRegex.hasMatch(date)) {
      return "Formato no válido";
    } else {
      return null;
    }
  }

  static noRequiredDateTimeDMY(String? value, String date) {
    RegExp fechaRegex =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[012])\/\d{4}$');
    if (value == null || value.isEmpty) {
      return null;
    } else if (!fechaRegex.hasMatch(date)) {
      return "Formato no válido";
    } else {
      return null;
    }
  }

  static String? regexFormSearch(
    String? value,
  ) {
    final regExp = RegExp(r'^$|^[0-9a-zA-ZáéíóúÁÉÍÓÚñÑ\s\-\_\(\)\/]*$');
    if (value == null || value.isEmpty) {
      return null;
    } else if (!regExp.hasMatch(value)) {
      return "Caracteres permitidos '/', '-' , '_' y '()'";
    } else {
      return null;
    }
  }

  /* 📌 comparar fechas en formato yyyy/mm/dd*/
  static int compareDates(String date1, String date2) {
    DateFormat format = DateFormat("yyyy/MM/dd");
    if (date1.isEmpty || date2.isEmpty) {
      return 0;
    }
    try {
      DateTime dateTime1 = format.parseStrict(date1);
      DateTime dateTime2 = format.parseStrict(date2);
      return dateTime1.compareTo(dateTime2);
    } catch (e) {
      // Error de formato de fecha
      return 0;
    }
  }

/* 📌 comparar fechas en formato dd/mm/yyyy*/
  static int compareDatesDMY(String date1, String date2) {
    DateFormat format = DateFormat("dd/MM/yyyy");
    if (date1.isEmpty || date2.isEmpty) {
      return 0;
    }
    try {
      DateTime dateTime1 = format.parseStrict(date1);
      DateTime dateTime2 = format.parseStrict(date2);
      return dateTime1.compareTo(dateTime2);
    } catch (e) {
      // Error de formato de fecha
      return 0;
    }
  }

  /* 📌 Formato del calendario */
  static String dateToStringTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(dateTime);
  }

  /* 📌 Formato del calendario dd/mm/yyyy */
  static String dateToStringTimeDMY(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  Color getCircleColor(int idValidacion) {
    Color circleColor;
    switch (idValidacion) {
      case 1:
        circleColor = AppColors.validationTimely;
        break;
      case 2:
        circleColor = AppColors.validationLate;
        break;
      case 3:
        circleColor = AppColors.validationMissing;
        break;
      default:
        circleColor = AppColors.validationJustified;
        break;
    }
    return circleColor;
  }

  String getWeekCurrent() {
    final now = DateTime.now();
    // Obtén el día de la semana actual (0 = domingo, 1 = lunes, ..., 6 = sábado)
    final currentDayOfWeek = now.weekday;
    // Calcula la fecha del lunes de la semana actual
    final startOfWeek = now.subtract(Duration(days: currentDayOfWeek - 1));
    // Calcula la fecha del viernes de la semana actual
    final endOfWeek = startOfWeek.add(const Duration(days: 4));
    final format = DateFormat('dd', 'es');
    final monthFormat = DateFormat('MMM', 'es');
    final startDayFormatted = format.format(startOfWeek);
    final endDayFormatted = format.format(endOfWeek);
    final monthFormatted = monthFormat.format(startOfWeek);

    return '$startDayFormatted - $endDayFormatted $monthFormatted.';
  }

  String getDateLarge() {
    final now = DateTime.now();
    final format = DateFormat('EEEE dd \'de\' MMM.', 'es');
    return format.format(now);
  }

  String formatDateNormal(DateTime fecha) {
    final DateFormat formato = DateFormat('yyyy-MM-dd');
    return formato.format(fecha);
  }

  String formatDateShort(DateTime fecha) {
    final DateFormat formato = DateFormat('yyyy-MM');
    return formato.format(fecha);
  }

  static Future<void> getShowModalBS(
    BuildContext context, {
    required String title,
    required Widget content,
  }) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50.0,
                  height: 10.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor(context),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor(context),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kRadiusNormal),
                      topRight: Radius.circular(kRadiusNormal),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          title,
                          style: AppTextStyle(context).bold16(),
                        ),
                      ),
                      content,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /* 📌 Comparar que las contraseñas ingresadas sean iguales */
  static String? comparePassword(String firstPass, String secondPass) {
    if (firstPass != secondPass) {
      return "Asegúrate de que las contraseñas sean idénticas";
    } else {
      return null;
    }
  }

  /* 📌 Validar fecha en formato yyyy/MM/dd  */
  static String? validateDateFormat(String? value) {
    if (value == null || value.isEmpty) {
      return "Seleccionar una fecha";
    } else {
      final RegExp dateRegex =
          RegExp(r'^\d{4}\/(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])$');
      if (!dateRegex.hasMatch(value)) {
        return "Formato de fecha inválido";
      }
      return null;
    }
  }

  /* 📌 Validar fecha en formato dd/MM/yyyy */
  static String? validateDateFormatDMY(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else {
      final RegExp dateRegex =
          RegExp(r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[012])\/\d{4}$');
      if (!dateRegex.hasMatch(value)) {
        return "Formato de fecha inválido";
      }
      return null;
    }
  }

  /* 📌 Cambiar formato de fecha de yyyy/MM/dd a dd/MM/yyyy */
  static String changeDateToddMMyyyy(String date) {
    DateFormat inputFormat =
        DateFormat('yyyy/MM/dd'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de salida

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }

  /* 📌 Cambiar formato de fecha de  dd/MM/yyyy  a yyyy/MM/dd */
  static String changeDateToyyyyMMdd(String date) {
    DateFormat inputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('yyyy/MM/dd'); // Define el formato de salida

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }

  // 📌 Saber que tipo de error es y mostrar un mensaje descriptivo al usuario
   static String knowTypeError(error) {
    if (error.toString().contains('NOT_INTERNET_EXCEPTION')) {
      return "kmessageErrorNetwork";
    }
    if (error.toString().contains('TIME_OUT')) {
      return "messageErrorOnTimeOut";
    }
    if (error.toString().contains('connection error')) {
      return "messageErrorNotResponse";
    } else {
      return "kmessageErrorGeneral";
    }

  }

  /* 📌 Cambiar formato de fecha de yyyy/MM/dd a dd/MM/yyyy */
  static String changeDateTodMy(String date) {
    DateFormat inputFormat =
        DateFormat('yyyy-MM-dd'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de salida

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }
}
