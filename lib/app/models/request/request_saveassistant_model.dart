class RequestSaveassistantModel {
    String? pAsistenciaid;
    String? pPersonalId;
    String? pTipo;
    String? pComentario;
    String? pTextFoto;

    RequestSaveassistantModel({
        this.pAsistenciaid,
        this.pPersonalId,
        this.pTipo,
        this.pComentario,
        this.pTextFoto,
    });

    Map<String, dynamic> toJson() => {
        "pAsistenciaid": pAsistenciaid,
        "pPersonalId": pPersonalId,
        "pTipo": pTipo,
        "pComentario": pComentario,
        "pTextFoto": pTextFoto,
    };
}