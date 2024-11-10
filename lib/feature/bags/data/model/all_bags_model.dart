class AllBagsModel {
  AllBagsModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final List<Data> data;

  AllBagsModel.fromJson(Map<String, dynamic> json){
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
    required this.state,
    this.previousState,
    required this.isAvailable,
  });
  late final int id;
  late final String state;
  late final String? previousState;
  late final bool isAvailable;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    state = json['state'];
    previousState = json['previousState'];
    isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['state'] = state;
    _data['previous_state'] = previousState;
    _data['is_available'] = isAvailable;
    return _data;
  }
}