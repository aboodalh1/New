class LoginUserModel {
  LoginUserModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final Data data;

  LoginUserModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.token,
    required this.role,
  });
  late final String token;
  late final String role;

  Data.fromJson(Map<String, dynamic> json){
    token = json['token'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['role'] = role;
    return _data;
  }
}