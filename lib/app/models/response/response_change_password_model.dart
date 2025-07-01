class ResponseChangePasswordModel {
    final bool? success;
    final int? statusCode;
    final String? statusMessage;
    final String? data;

    ResponseChangePasswordModel({
        this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseChangePasswordModel.fromJson(Map<String, dynamic> json) => ResponseChangePasswordModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data,
    };
}
