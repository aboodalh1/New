class HomeReadsModel {
  HomeReadsModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final List<Data> data;

  HomeReadsModel.fromJson(Map<String, dynamic> json){
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
    required this.userName,
    required this.userRole,
    required this.customerName,
    required this.bagId,
    required this.status,
    required this.date,
  });
  late final String userName;
  late final String userRole;
  late final String customerName;
  late final int bagId;
  late final String status;
  late final String date;

  Data.fromJson(Map<String, dynamic> json){
    userName = json['user_name'];
    userRole = json['user_role'];
    customerName = json['customer_name'];
    bagId = json['bag_id'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_name'] = userName;
    _data['user_role'] = userRole;
    _data['customer_name'] = customerName;
    _data['bag_id'] = bagId;
    _data['status'] = status;
    _data['date'] = date;
    return _data;
  }
}