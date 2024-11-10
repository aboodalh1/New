class AllMessageModel {
  AllMessageModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final List<Data> data;

  AllMessageModel.fromJson(Map<String, dynamic> json){
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
    required this.message,
    required this.type,
    required this.sender,
    required this.createdAt,
  });
  late final int id;
  late final String message;
  late final String type;
  late final String? sender;
  late final String createdAt;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    message = json['message'];
    type = json['type'];
    sender = json['sender']??'';
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['message'] = message;
    _data['type'] = type;
    _data['sender'] = sender;
    _data['created_at'] = createdAt;
    return _data;
  }
}