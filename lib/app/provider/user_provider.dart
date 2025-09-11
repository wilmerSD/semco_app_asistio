import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:semco_app_asistio/app/models/request/request_login_model.dart';
import 'package:semco_app_asistio/app/models/request/request_saveassistant_model.dart';
import 'package:semco_app_asistio/app/models/response/response_change_password_model.dart';
import 'package:semco_app_asistio/app/models/response/response_infopersonal_model.dart';
import 'package:semco_app_asistio/app/models/response/response_inforassistant_model.dart';
import 'package:semco_app_asistio/app/models/response/response_saveassistant_model.dart';
import 'package:semco_app_asistio/app/models/response/response_upload_image.dart';
import 'package:semco_app_asistio/main.dart';

class UserProvider with ChangeNotifier {
  // get dioClient => null;

  Future<ResponseInfopersonalModel> postLogin(RequestLoginModel request) async {
    final response = await dioClient.post(
      path: "/PostPrcValidaLogin02",
      bodyRaw: request.toJson(),
    );
    return ResponseInfopersonalModel.fromJson(response);
  }

  Future<ResponseInforassistantModel> getInfoAssistant(
    String personalid,
  ) async {
    final response = await dioClient.get(
      path: "/GetProc_InfoAssistant",
      queryParameters: {"Ppersonalid": personalid},
    );
    return ResponseInforassistantModel.fromJson(response);
  }

  /* Future<ResponseSaveassistantModel> postSaveAssistant(
      RequestSaveassistantModel request, XFile pXfile) async {
    final response = await dioClient.post(
        path: "/PostProc_GuardarAsistencia", bodyRaw: request.toJson(),
        
        );
    return ResponseSaveassistantModel.fromJson(response);
  }
 */
  Future<String> postSaveImage(File pFile) async {
    final response = await dioClient.post(path: "/gxobject", file: pFile);
    return response;
  }

  Future<ResponseUploadImage> postSaveImageBytes(Uint8List bytes) async {
    final response = await dioClient.post(path: "/gxobject", fileBytes: bytes);
    return ResponseUploadImage.fromJson(response);
  }

  Future<ResponseSaveassistantModel> postSaveAssistant(
    RequestSaveassistantModel request,
  ) async {
    final response = await dioClient.post(
      path: "/SaveAssist",
      bodyRaw: request.toJson(),
    );
    return ResponseSaveassistantModel.fromJson(response);
  }

  Future<ResponseChangePasswordModel> postSendEmail(String email) async {
    final response = await dioClient.post(
      path: "/PostSendEmail",
      bodyRaw: {"iEmail": email},
    );
    return ResponseChangePasswordModel.fromJson(response);
  }

  Future<ResponseChangePasswordModel> postVerificationCode(
    String codeSend,
    String codeGenerate,
  ) async {
    final response = await dioClient.post(
      path: "/PostVerificationCode",
      bodyRaw: {'iCodeSend': codeSend, 'iCodeGenerate': codeGenerate},
    );
    return ResponseChangePasswordModel.fromJson(response);
  }

  Future<ResponseChangePasswordModel> postChangePassword(
    String password, String passwordRepeat, String personalId
  ) async {
    final response = await dioClient.post(
      path: "/PostChangePassword",
      bodyRaw: {
        "iPassword": password,
        "iPasswordRepeat": passwordRepeat,
        "iPersonalId": personalId
      }
    );
    return ResponseChangePasswordModel.fromJson(response);
  }
}
