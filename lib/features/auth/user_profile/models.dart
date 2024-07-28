class UserProfileModel {
  String? firstName;
  String? lastName;
  dynamic userProfilePic;
  String? email;
  String? phoneNumber;
  // phone_is_verified
  bool? phoneNumberVerified;

  UserProfileModel(
      {this.firstName,
      this.lastName,
      this.userProfilePic,
      this.email,
      this.phoneNumber,
      this.phoneNumberVerified});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    userProfilePic = json['user_profile_pic'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    phoneNumberVerified = json['phone_is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_profile_pic'] = userProfilePic;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data["phone_is_verified"] = phoneNumberVerified;
    return data;
  }
}
