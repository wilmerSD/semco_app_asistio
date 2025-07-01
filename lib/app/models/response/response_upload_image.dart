class ResponseUploadImage {
    final String? objectId;

    ResponseUploadImage({
        this.objectId,
    });

    factory ResponseUploadImage.fromJson(Map<String, dynamic> json) => ResponseUploadImage(
        objectId: json["object_id"],
    );

    Map<String, dynamic> toJson() => {
        "object_id": objectId,
    };
}
