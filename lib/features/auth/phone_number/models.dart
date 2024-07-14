class SentTokenModel {
  int? alternativeOtps;
  String? message;

  SentTokenModel({this.alternativeOtps, this.message});

  SentTokenModel.fromJson(Map<String, dynamic> json) {
    alternativeOtps = json['alternative_otps'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alternative_otps'] = this.alternativeOtps;
    data['message'] = this.message;
    return data;
  }
}
