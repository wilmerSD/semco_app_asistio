
class ResponseSaveassistantModel {
    String ppAsistenciaid;

    ResponseSaveassistantModel({
        required this.ppAsistenciaid,
    });

    factory ResponseSaveassistantModel.fromJson(Map<String, dynamic> json) => ResponseSaveassistantModel(
        ppAsistenciaid: json["ppAsistenciaid"],
    );
}   