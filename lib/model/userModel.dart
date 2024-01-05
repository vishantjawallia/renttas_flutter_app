class UserModel {
  final String id;
  final String name;
  final String mobileNo;
  final String currency;
  final String email;
  final String address;
  final String password;
  final String role;
  final String updatedAt;
  final String createdAt;
  final String overallStatus;
  final String message;

  UserModel({
    required this.id,
    required this.name,
    required this.mobileNo,
    required this.currency,
    required this.email,
    required this.address,
    required this.password,
    required this.role,
    required this.updatedAt,
    required this.createdAt,
    required this.overallStatus,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(

      id: json['data']==null?"": json['data']['id'],
      name: json['data']==null?"":json['data']['name'],
      mobileNo:json['data']==null?"": json['data']['mobileNo'],
      currency:json['data']==null?"": json['data']['currency'],
      email:json['data']==null?"": json['data']['email'],
      address:json['data']==null?"": json['data']['address'],
      password:json['data']==null?"": json['data']['password'],
      role:json['data']==null?"": json['data']['role'],
      updatedAt:json['data']==null?"": json['data']['updatedAt'],
      createdAt:json['data']==null?"": json['data']['createdAt'],
      overallStatus: json['loginstatus'] ?? "",
      message: json['msg'],
    );
  }
}
