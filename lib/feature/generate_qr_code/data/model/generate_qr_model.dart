class GenerateQrModel {
  GenerateQrModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final GenerateQrDataModel data;

  GenerateQrModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = GenerateQrDataModel.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class GenerateQrDataModel {
  GenerateQrDataModel({
    required this.qrContent,
    required this.customerName,
    required this.bagId,
  });
  late final String qrContent;
  late final String customerName;
  late final String expiryDate;
  late final num bagId;

  GenerateQrDataModel.fromJson(Map<String, dynamic> json) {
    qrContent = json['qr_content'];
    customerName = json['customer_name'];
    bagId = json['bag_id'];
    expiryDate = json['expiry_date'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['qr_content'] = qrContent;
    _data['customer_name'] = customerName;
    _data['bag_id'] = bagId;
    return _data;
  }
}
