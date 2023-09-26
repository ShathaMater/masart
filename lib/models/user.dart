class UserModel {
  late String? id;
  late String? username;
  late String? email;
  bool isAuth;
  late String? timestamp;
  String? sex;
  String? mobile;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.timestamp,
    this.isAuth = false,
    this.sex,
    this.mobile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'].toString(),
      username: json['username'].toString(),
      email: json['email'].toString(),
      timestamp: json['timestamp'].toString(),
      isAuth: true,
      sex: json['sex'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": id,
        "username": username,
        "email": email,
        'timestamp': timestamp,
        'is_auth': isAuth,
        'sex': sex,
        'mobile': mobile,
      };
}
