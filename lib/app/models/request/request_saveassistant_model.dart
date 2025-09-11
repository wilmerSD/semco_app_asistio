class RequestSaveassistantModel {
    String? pAsistenciaid;
    String? pPersonalId;
    String? pTipo;
    String? pComentario;
    String? pTextFoto;
    double iLatitude;
    double iLongitude;
    String iNameLoc;

    RequestSaveassistantModel({
        this.pAsistenciaid,
        this.pPersonalId,
        this.pTipo,
        this.pComentario,
        this.pTextFoto,
        required this.iLatitude,
        required this.iLongitude,
        required this.iNameLoc,
    });

    Map<String, dynamic> toJson() => {
        "pAsistenciaid": pAsistenciaid,
        "pPersonalId": pPersonalId,
        "pTipo": pTipo,
        "pComentario": pComentario,
        "pTextFoto": pTextFoto,
        "iLatitude": iLatitude,
        "iLongitude": iLongitude,
        "iNameLoc": iNameLoc,
    };
}