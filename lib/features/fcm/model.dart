class FcmTokenModel {
  int? user;
  String? fcmToken;
  String? timeStamp;
  bool? isStale;
  String? staleTime;

  FcmTokenModel(
      {this.user, this.fcmToken, this.timeStamp, this.isStale, this.staleTime});

  FcmTokenModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    fcmToken = json['fcm_token'];
    timeStamp = json['time_stamp'];
    isStale = json['is_stale'];
    staleTime = json['stale_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['fcm_token'] = this.fcmToken;
    data['time_stamp'] = this.timeStamp;
    data['is_stale'] = this.isStale;
    data['stale_time'] = this.staleTime;
    return data;
  }
}
