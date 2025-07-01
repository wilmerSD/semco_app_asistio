import 'package:semco_app_asistio/app/models/request/request_login_model.dart';
import 'package:semco_app_asistio/app/models/response/response_infopersonal_model.dart';
import 'package:semco_app_asistio/app/models/response/response_inforassistant_model.dart';
import 'package:semco_app_asistio/app/provider/user_provider.dart';

class UserRepository {
  final UserProvider _apiProvider = UserProvider();

  Future<ResponseInfopersonalModel> postLogin(
    RequestLoginModel request,
  ) =>
      _apiProvider.postLogin(request);

  Future<ResponseInforassistantModel> getInfoAssistant(String personalid) =>
      _apiProvider.getInfoAssistant(personalid);

 /*  Future<ResponseSaveassistantModel> postSaveAssistant(
          RequestSaveassistantModel request) =>
      _apiProvider.postSaveAssistant(request); */
}
