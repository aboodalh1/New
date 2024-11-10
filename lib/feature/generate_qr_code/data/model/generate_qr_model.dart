class GenerateQrModel {
  GenerateQrModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final Data data;

  GenerateQrModel.fromJson(Map<String, dynamic> json){
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
    required this.qrContent,
    required this.customerName,
    required this.bagId,
  });
  late final String qrContent;
  late final String customerName;
  late final num bagId;

  Data.fromJson(Map<String, dynamic> json){
    qrContent = json['qr_content'];
    customerName = json['customer_name'];
    bagId = json['bag_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['qr_content'] = qrContent;
    _data['customer_name'] = customerName;
    _data['bag_id'] = bagId;
    return _data;
  }
}