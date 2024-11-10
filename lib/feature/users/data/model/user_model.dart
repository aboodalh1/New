class UserModel {
  UserModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final UserData data;

  UserModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    data = UserData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.phone,
    required this.employeeNumber,
    required this.image,
    required this.verified,
    required this.role,
  });
  late final int id;
  late final String name;
  late final String phone;
  late final String employeeNumber;
  late final String image;
  late final bool verified;
  late final String role;

  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    employeeNumber = json['employee_number']??'';
    image = json['image']??'';
    verified = json['verified'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['employee_number'] = employeeNumber;
    _data['image'] = image;
    _data['verified'] = verified;
    _data['role'] = role;
    return _data;
  }
}