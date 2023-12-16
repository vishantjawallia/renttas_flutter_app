class Welcome {
  String respCode;
  List<GetStore> data;

  Welcome({
    required this.respCode,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        respCode: json["respCode"],
        data: List<GetStore>.from(json["data"].map((x) => GetStore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetStore {
  String id;
  String userid;
  String storename;
  String status;

  GetStore({
    required this.id,
    required this.userid,
    required this.storename,
    required this.status,
  });

  factory GetStore.fromJson(Map<String, dynamic> json) => GetStore(
        id: json["id"],
        userid: json["userid"],
        storename: json["storename"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "storename": storename,
        "status": status,
      };
}
