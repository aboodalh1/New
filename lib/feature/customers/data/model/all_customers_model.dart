class AllCustomersModel {
  AllCustomersModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final List<Data> data;

  AllCustomersModel.fromJson(Map<String, dynamic> json){
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
    required this.address,
    required this.phone,
    required this.driverName,
    required this.state,
    required this.reservedBags,
    required this.bags,
  });
  late final int id;
  late final String name;
  late final String address;
  late final String phone;
  late final String driverName;
  late final String state;
  late final int reservedBags;
  late final List<int> bags;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    driverName = json['driver_name'];
    state = json['state'];
    reservedBags = json['reserved_bags'];
    bags = List.castFrom<dynamic, int>(json['bags']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['driver_name'] = driverName;
    _data['state'] = state;
    _data['reserved_bags'] = reservedBags;
    _data['bags'] = bags;
    return _data;
  }
}