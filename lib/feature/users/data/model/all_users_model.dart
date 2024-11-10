class AllUsersModel {
  AllUsersModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final List<Data> data;

  AllUsersModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.phone,
    this.employeeNumber,
    this.image,
    required this.verified,
    required this.role,
  });
  late final int id;
  late final String name;
  late final String phone;
  late final String? employeeNumber;
  late final String? image;
  late final bool verified;
  late final String role;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    employeeNumber = json['employee_number']??'1';
    image = json['image']??'';
    verified = json['verified'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['employee_number'] = employeeNumber;
    data['image'] = image;
    data['verified'] = verified;
    data['role'] = role;
    return data;
  }
}