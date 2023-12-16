

class Welcome {
  String respCode;
  List<GetCompany> data;

  Welcome({
    required this.respCode,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    respCode: json["respCode"],
    data: List<GetCompany>.from(json["data"].map((x) => GetCompany.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "respCode": respCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetCompany {
  String id;
  String userid;
  String companyname;
  String address;
  String status;

  GetCompany({
    required this.id,
    required this.userid,
    required this.companyname,
    required this.address,
    required this.status,
  });

  factory GetCompany.fromJson(Map<String, dynamic> json) => GetCompany(
    id: json["id"],
    userid: json["userid"],
    companyname: json["companyname"],
    address: json["address"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "companyname": companyname,
    "address": address,
    "status": status,
  };
}
