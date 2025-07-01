class ResponseInfopersonalModel {
    bool success;
    int? statusCode;
    String? statusMessage;
    List<Datum>? data;

    ResponseInfopersonalModel({
        required this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseInfopersonalModel.fromJson(Map<String, dynamic> json) => ResponseInfopersonalModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
}

class Datum {
    String? personalId;
    String? personalNombres;
    String? personalApellidos;
    String? personalDni;
    bool? personalEstado;
    String? empresaid;
    String? empresaRazonsocial;
    String? areaId;
    String? areaNombre;
    String? cargoId;
    String? cargoNombre;
    String? horarioId;
    String? horarioNombre;
    String? personalUsuario;
    String? personalContrasena;
    String? personalRol;
    String? personalCorreo;
    String? personalFoto;
    String? personalNombreCompleto;
    String? personalPhoto;

    Datum({
        this.personalId,
        this.personalNombres,
        this.personalApellidos,
        this.personalDni,
        this.personalEstado,
        this.empresaid,
        this.empresaRazonsocial,
        this.areaId,
        this.areaNombre,
        this.cargoId,
        this.cargoNombre,
        this.horarioId,
        this.horarioNombre,
        this.personalUsuario,
        this.personalContrasena,
        this.personalRol,
        this.personalCorreo,
        this.personalFoto,
        this.personalNombreCompleto,
        this.personalPhoto,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        personalId: json["PersonalId"],
        personalNombres: json["PersonalNombres"],
        personalApellidos: json["PersonalApellidos"],
        personalDni: json["PersonalDni"],
        personalEstado: json["PersonalEstado"],
        empresaid: json["Empresaid"],
        empresaRazonsocial: json["EmpresaRazonsocial"],
        areaId: json["AreaId"],
        areaNombre: json["AreaNombre"],
        cargoId: json["CargoId"],
        cargoNombre: json["CargoNombre"],
        horarioId: json["HorarioID"],
        horarioNombre: json["HorarioNombre"],
        personalUsuario: json["PersonalUsuario"],
        personalContrasena: json["PersonalContrasena"],
        personalRol: json["PersonalRol"],
        personalCorreo: json["PersonalCorreo"],
        personalFoto: json["PersonalFoto"],
        personalNombreCompleto: json["PersonalNombreCompleto"],
        personalPhoto: json["PersonalPhoto"],
    );
}