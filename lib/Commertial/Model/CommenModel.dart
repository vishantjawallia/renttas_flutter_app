// ignore_for_file: file_names

class CommonModel {
  CommonModel({
    required this.respCode,
    required this.respMsg,
  });

  String respCode;
  String respMsg;

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
        respCode: json["respCode"],
        respMsg: json["respMsg"],
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "respMsg": respMsg,
      };
}
