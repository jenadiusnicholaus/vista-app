import 'package:vista/shared/models.dart';

class MyRentingModel {
  int? id;
  Property? property;
  RentingDuration? rentingDuration;
  dynamic totalPrice;
  dynamic checkIn;
  dynamic checkOut;
  int? totalFamilyMember;
  int? adult;
  int? children;
  dynamic createdAt;
  dynamic updatedAt;
  MyPaymentCard? myPaymentCard;
  MyMwPayment? myMwPayment;
  RentingStatus? rentingStatus;

  MyRentingModel({
    this.id,
    this.property,
    this.rentingDuration,
    this.totalPrice,
    this.checkIn,
    this.checkOut,
    this.totalFamilyMember,
    this.adult,
    this.children,
    this.createdAt,
    this.updatedAt,
    this.myPaymentCard,
    this.myMwPayment,
    this.rentingStatus,
  });

  MyRentingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    property =
        json['property'] != null ? Property.fromJson(json['property']) : null;

    // rentingDuration = json['renting_duration'];
    totalPrice = json['total_price'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    totalFamilyMember = json['total_family_member'];
    adult = json['adult'];
    children = json['children'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    myPaymentCard = json['my_payment_card'] != null
        ? MyPaymentCard.fromJson(json['my_payment_card'])
        : null;
    myMwPayment = json['my_mw_payment'] != null
        ? MyMwPayment.fromJson(json['my_mw_payment'])
        : null;
    rentingStatus = json['renting_status'] != null
        ? RentingStatus.fromJson(json['renting_status'])
        : null;

    rentingDuration = json['renting_duration'] != null
        ? RentingDuration.fromJson(json['renting_duration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (property != null) {
      data['property'] = property!.toJson();
    }
    // data['renting_duration'] = rentingDuration;
    data['total_price'] = totalPrice;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['total_family_member'] = totalFamilyMember;
    data['adult'] = adult;
    data['children'] = children;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (myPaymentCard != null) {
      data['my_payment_card'] = myPaymentCard!.toJson();
    }
    if (myMwPayment != null) {
      data['my_mw_payment'] = myMwPayment!.toJson();
    }
    if (rentingStatus != null) {
      data['renting_status'] = rentingStatus!.toJson();
    }
    if (rentingDuration != null) {
      data['renting_duration'] = rentingDuration!.toJson();
    }
    return data;
  }
}

class MyPaymentCard {
  dynamic id;
  dynamic accountNumber;
  dynamic bankName;
  dynamic cardHolderName;
  dynamic cardExpiry;
  dynamic cardCvv;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic user;

  MyPaymentCard(
      {this.id,
      this.accountNumber,
      this.bankName,
      this.cardHolderName,
      this.cardExpiry,
      this.cardCvv,
      this.createdAt,
      this.updatedAt,
      this.user});

  MyPaymentCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    cardHolderName = json['card_holder_name'];
    cardExpiry = json['card_expiry'];
    cardCvv = json['card_cvv'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['account_number'] = accountNumber;
    data['bank_name'] = bankName;
    data['card_holder_name'] = cardHolderName;
    data['card_expiry'] = cardExpiry;
    data['card_cvv'] = cardCvv;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user;
    return data;
  }
}

class MyMwPayment {
  int? id;
  dynamic mobileNumber;
  dynamic mobileHolderName;
  dynamic mobileNetwork;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic user;

  MyMwPayment(
      {this.id,
      this.mobileNumber,
      this.mobileHolderName,
      this.mobileNetwork,
      this.createdAt,
      this.updatedAt,
      this.user});

  MyMwPayment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileNumber = json['mobile_number'];
    mobileHolderName = json['mobile_holder_name'];
    mobileNetwork = json['mobile_network'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['mobile_number'] = mobileNumber;
    data['mobile_holder_name'] = mobileHolderName;
    data['mobile_network'] = mobileNetwork;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user;
    return data;
  }
}

class RentingStatus {
  bool? rentingRequestConfirmed;
  dynamic rentingStatus;
  dynamic confirmedAt;
  dynamic startedAt;
  dynamic canceledAt;
  dynamic user;
  dynamic renting;

  RentingStatus(
      {this.rentingRequestConfirmed,
      this.rentingStatus,
      this.confirmedAt,
      this.startedAt,
      this.canceledAt,
      this.user,
      this.renting});

  RentingStatus.fromJson(Map<String, dynamic> json) {
    rentingRequestConfirmed = json['renting_request_confirmed'];
    rentingStatus = json['renting_status'];
    confirmedAt = json['confirmed_at'];
    startedAt = json['started_at'];
    canceledAt = json['canceled_at'];
    user = json['user'];
    renting = json['renting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['renting_request_confirmed'] = rentingRequestConfirmed;
    data['renting_status'] = rentingStatus;
    data['confirmed_at'] = confirmedAt;
    data['started_at'] = startedAt;
    data['canceled_at'] = canceledAt;
    data['user'] = user;
    data['renting'] = renting;
    return data;
  }
}

class RentingDuration {
  int? id;
  int? timeInNumber;
  String? timeInText;
  String? createdAt;
  String? updatedAt;
  int? property;

  RentingDuration(
      {this.id,
      this.timeInNumber,
      this.timeInText,
      this.createdAt,
      this.updatedAt,
      this.property});

  RentingDuration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeInNumber = json['time_in_number'];
    timeInText = json['time_in_text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['time_in_number'] = timeInNumber;
    data['time_in_text'] = timeInText;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['property'] = property;
    return data;
  }
}
