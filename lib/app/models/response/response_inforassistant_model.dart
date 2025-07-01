class ResponseInforassistantModel {
    bool success;
    int? statusCode;
    String? statusMessage;
    List<DataInfoAssistant>? data;

    ResponseInforassistantModel({
        required this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseInforassistantModel.fromJson(Map<String, dynamic> json) => ResponseInforassistantModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<DataInfoAssistant>.from(json["data"]!.map((x) => DataInfoAssistant.fromJson(x))),
    );

}

class DataInfoAssistant {
    String? asistenciaId;
    String? asistenciaTipo;
    String? tomaAFecha;
    String? tomaAFoto;
    String? tomaAIngreso;
    bool? tomaATieneRegrigerio;
    String? tomaAInicioComida;
    String? tomaAFinComida;
    String? tomaASalida;
    String? tomaAObsIngreso;
    String? tomaAObsInicioComida;
    String? tomaAObsFinComida;
    String? tomaAObsSalida;
    String? ubicacion;
    bool? tomaAsistenciaJustificado;
    String? tomaAsistRazonJustificacion;
    bool? tomaAConGoce;
    String? ausenciaId;
    String? tipoAusenciaId;
    String? tipoAusenciaNombre;
    bool? horasTrabajoDiaLibre;
    String? asistenciaTipoDescription;

    DataInfoAssistant({
        this.asistenciaId,
        this.asistenciaTipo,
        this.tomaAFecha,
        this.tomaAFoto,
        this.tomaAIngreso,
        this.tomaATieneRegrigerio,
        this.tomaAInicioComida,
        this.tomaAFinComida,
        this.tomaASalida,
        this.tomaAObsIngreso,
        this.tomaAObsInicioComida,
        this.tomaAObsFinComida,
        this.tomaAObsSalida,
        this.ubicacion,
        this.tomaAsistenciaJustificado,
        this.tomaAsistRazonJustificacion,
        this.tomaAConGoce,
        this.ausenciaId,
        this.tipoAusenciaId,
        this.tipoAusenciaNombre,
        this.horasTrabajoDiaLibre,
        this.asistenciaTipoDescription,
    });

    factory DataInfoAssistant.fromJson(Map<String, dynamic> json) => DataInfoAssistant(
        asistenciaId: json["AsistenciaId"],
        asistenciaTipo: json["AsistenciaTipo"],
        tomaAFecha: json["TomaAFecha"],
        tomaAFoto: json["TomaAFoto"],
        tomaAIngreso: json["TomaAIngreso"],
        tomaATieneRegrigerio: json["TomaATieneRegrigerio"],
        tomaAInicioComida: json["TomaAInicioComida"],
        tomaAFinComida: json["TomaAFinComida"],
        tomaASalida: json["TomaASalida"],
        tomaAObsIngreso: json["TomaAObsIngreso"],
        tomaAObsInicioComida: json["TomaAObsInicioComida"],
        tomaAObsFinComida: json["TomaAObsFinComida"],
        tomaAObsSalida: json["TomaAObsSalida"],
        ubicacion: json["ubicacion"],
        tomaAsistenciaJustificado: json["TomaAsistenciaJustificado"],
        tomaAsistRazonJustificacion: json["TomaAsistRazonJustificacion"],
        tomaAConGoce: json["TomaAConGoce"],
        ausenciaId: json["AusenciaId"],
        tipoAusenciaId: json["TipoAusenciaId"],
        tipoAusenciaNombre: json["TipoAusenciaNombre"],
        horasTrabajoDiaLibre: json["HorasTrabajoDiaLibre"],
        asistenciaTipoDescription: json["AsistenciaTipoDescription"],
    );
}