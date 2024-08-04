class UserProfileModel {
  String? firstName;
  String? lastName;
  Null? userProfilePic;
  String? email;
  String? phoneNumber;
  bool? phoneIsVerified;
  FcmToken? fcmToken;

  UserProfileModel(
      {this.firstName,
      this.lastName,
      this.userProfilePic,
      this.email,
      this.phoneNumber,
      this.phoneIsVerified,
      this.fcmToken});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    userProfilePic = json['user_profile_pic'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    phoneIsVerified = json['phone_is_verified'];
    fcmToken =
        json['fcm_token'] != null ? FcmToken.fromJson(json['fcm_token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_profile_pic'] = userProfilePic;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['phone_is_verified'] = phoneIsVerified;
    if (fcmToken != null) {
      data['fcm_token'] = fcmToken!.toJson();
    }
    return data;
  }
}

class FcmToken {
  int? user;
  String? fcmToken;
  String? timeStamp;
  bool? isStale;
  String? staleTime;

  FcmToken(
      {this.user, this.fcmToken, this.timeStamp, this.isStale, this.staleTime});

  FcmToken.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    fcmToken = json['fcm_token'];
    timeStamp = json['time_stamp'];
    isStale = json['is_stale'];
    staleTime = json['stale_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user'] = user;
    data['fcm_token'] = fcmToken;
    data['time_stamp'] = timeStamp;
    data['is_stale'] = isStale;
    data['stale_time'] = staleTime;
    return data;
  }
}
