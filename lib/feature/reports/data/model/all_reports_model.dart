class AllReportsModel {
  AllReportsModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final Data data;

  AllReportsModel.fromJson(Map<String, dynamic> json){
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
    required this.cards,
    required this.table,
  });
  late final Cards cards;
  late final List<TableModel> table;

  Data.fromJson(Map<String, dynamic> json){
    cards = Cards.fromJson(json['cards']);
    table = List.from(json['table']).map((e)=>TableModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cards'] = cards.toJson();
    _data['table'] = table.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Cards {
  Cards({
    required this.storedStage_1,
    required this.storedStage_2,
    required this.shipping,
    required this.delivered,
  });
  late final int storedStage_1;
  late final int storedStage_2;
  late final int shipping;
  late final int delivered;

  Cards.fromJson(Map<String, dynamic> json){
    storedStage_1 = json['stored_stage_1'];
    storedStage_2 = json['stored_stage_2'];
    shipping = json['shipping'];
    delivered = json['delivered'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stored_stage_1'] = storedStage_1;
    _data['stored_stage_2'] = storedStage_2;
    _data['shipping'] = shipping;
    _data['delivered'] = delivered;
    return _data;
  }
}
//====Zak==== change the name of model
class TableModel {
  TableModel({
    required this.customerName,
    required this.data,
  });
  late final String customerName;
  late final List<TableData> data;

  TableModel.fromJson(Map<String, dynamic> json){
    customerName = json['customer_name'];
    data = List.from(json['data']).map((e)=>TableData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customer_name'] = customerName;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}
class TableData{
  late final String bagState;
  late final String driverName;
  late final String date;
  TableData({
    required this.bagState,
    required this.driverName,
    required this.date,
});
  TableData.fromJson(Map<String, dynamic> json){
    bagState = json['bag_state'];
    driverName = json['driver_name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bag_state'] = bagState;
    _data['driver_name'] = driverName;
    _data['date'] = date;
    return _data;
  }
}