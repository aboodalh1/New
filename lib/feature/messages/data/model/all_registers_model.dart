class AllRegistersModel {
  AllRegistersModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final List<Data> data;

  AllRegistersModel.fromJson(Map<String, dynamic> json){
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
    required this.employeeNumber,
    this.image,
    required this.verified,
    required this.role,
  });
  late final int id;
  late final String name;
  late final String phone;
  late final String employeeNumber;
  late final String? image;
  late final bool verified;
  late final String role;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    employeeNumber = json['employee_number'];
    image = null;
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