class RegistrationModel {
  String? message;
  Data? data;

  RegistrationModel({this.message, this.data});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? dateOfBirth;
  bool? agreedToTerms;

  Data(
      {this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.dateOfBirth,
      this.agreedToTerms});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    agreedToTerms = json['agreed_to_Terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['agreed_to_Terms'] = this.agreedToTerms;
    return data;
  }
}
