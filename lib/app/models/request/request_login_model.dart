class RequestLoginModel {
    String? pUsername;
    String? pPassword;

    RequestLoginModel({
        this.pUsername,
        this.pPassword,
    });
    
    Map<String, dynamic> toJson() => {
        "pUsername": pUsername,
        "pPassword": pPassword,
    };
}
