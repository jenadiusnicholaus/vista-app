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

class ValidationErrorModel {
  MessageErrorModel? message;

  ValidationErrorModel({this.message});

  ValidationErrorModel.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'] != null
        ? MessageErrorModel.fromJson(json['message'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = Map<dynamic, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class MessageErrorModel {
  List<dynamic>? phoneNumber;
  List<dynamic>? password;
  List<dynamic>? email;
  List<dynamic>? phonenumber;

  MessageErrorModel(
      {this.phoneNumber, this.password, this.email, this.phonenumber});

  MessageErrorModel.fromJson(Map<dynamic, dynamic> json) {
    phoneNumber = json['phone_number'] != null
        ? json['phone_number'].cast<dynamic>()
        : [];
    password = json['password'] != null ? json['password'].cast<dynamic>() : [];
    email = json['email'] != null ? json['email'].cast<dynamic>() : [];
    phonenumber = json['phone_number'] != null
        ? json['phone_number'].cast<dynamic>()
        : [];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    data['email'] = email;
    data['phone_number'] = phonenumber;
    return data;
  }
}
