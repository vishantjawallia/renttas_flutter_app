

class Welcome {
  String respCode;
  List<GetLowStock> data;

  Welcome({
    required this.respCode,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    respCode: json["respCode"],
    data: List<GetLowStock>.from(json["data"].map((x) => GetLowStock.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "respCode": respCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetLowStock {
  String productname;
  String incount;
  String outcount;
  String stockcount;

  GetLowStock({
    required this.productname,
    required this.incount,
    required this.outcount,
    required this.stockcount,
  });

  factory GetLowStock.fromJson(Map<String, dynamic> json) => GetLowStock(
    productname: json["productname"],
    incount: json["incount"],
    outcount: json["outcount"],
    stockcount: json["stockcount"],
  );

  Map<String, dynamic> toJson() => {
    "productname": productname,
    "incount": incount,
    "outcount": outcount,
    "stockcount": stockcount,
  };
}
