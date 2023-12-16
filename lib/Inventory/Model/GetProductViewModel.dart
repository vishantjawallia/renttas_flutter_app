


class Welcome {
  String respCode;
  List<GetProduct> data;

  Welcome({
    required this.respCode,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    respCode: json["respCode"],
    data: List<GetProduct>.from(json["data"].map((x) => GetProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "respCode": respCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetProduct {
  String id;
  String userid;
  String storeid;
  String productname;
  String sku;
  String description;

  GetProduct({
    required this.id,
    required this.userid,
    required this.storeid,
    required this.productname,
    required this.sku,
    required this.description,
  });

  factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
    id: json["id"],
    userid: json["userid"],
    storeid: json["storeid"],
    productname: json["productname"],
    sku: json["sku"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "storeid": storeid,
    "productname": productname,
    "sku": sku,
    "description": description,
  };
}
