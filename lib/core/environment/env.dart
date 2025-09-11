enum ENV {
  DESA,
  QA,
  PROD,
}

extension Environment on ENV {
  static ENV type = ENV.DESA;
  static Map<String, dynamic> get appConfig {
    switch (type) {
      case ENV.DESA:
        return {
          "enviroment": "DESAROLLO",
          "baseUrl": 'http://192.168.100.8/appasistenciaNETFrameworkSQLServer/General/APIAssistant',
          "connectTimeout": 600000,
          "receiveTimeout": 600000,
          "sendTimeout": 600000,
        };
      case ENV.QA:
        return {
          "enviroment": "QA",
          "baseUrl": "https://apps.semco.com.pe/asistio_qa/General/APIAssistant",
          "connectTimeout": 600000,
          "receiveTimeout": 600000,
        };
      case ENV.PROD:
        return {
          "enviroment": "PRODUCCIÓN",
          "baseUrl": 'https://apps.semco.com.pe/asistencia/General/APIAssistant',
          "connectTimeout": 600000,
          "receiveTimeout": 600000,
        };
      default:
        return {
          "": "",
        };
    }
  }
}
