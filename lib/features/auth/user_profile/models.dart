class UserProfileModel {
  String? firstName;
  String? lastName;
  dynamic userProfilePic;
  String? email;
  String? phoneNumber;

  UserProfileModel(
      {this.firstName,
      this.lastName,
      this.userProfilePic,
      this.email,
      this.phoneNumber});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    userProfilePic = json['user_profile_pic'];
    email = json['email'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_profile_pic'] = this.userProfilePic;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}
