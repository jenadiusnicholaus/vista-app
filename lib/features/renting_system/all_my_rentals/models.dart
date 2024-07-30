import '../../../shared/models.dart';

class RentalsRequestModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<RentingRequestResults>? results;

  RentalsRequestModel({this.count, this.next, this.previous, this.results});

  RentalsRequestModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <RentingRequestResults>[];
      json['results'].forEach((v) {
        results!.add(RentingRequestResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RentingRequestResults {
  int? id;
  Property? property;
  Rdos? rentingDuration;
  String? totalPrice;
  String? checkIn;
  String? checkOut;
  int? totalFamilyMember;
  int? adult;
  int? children;
  String? createdAt;
  String? updatedAt;
  MyPaymentCard? myPaymentCard;
  MyMwPayment? myMwPayment;
  RentingStatus? rentingStatus;

  RentingRequestResults(
      {this.id,
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
      this.rentingStatus});

  RentingRequestResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    property =
        json['property'] != null ? Property.fromJson(json['property']) : null;
    rentingDuration = json['renting_duration'] != null
        ? Rdos.fromJson(json['renting_duration'])
        : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (property != null) {
      data['property'] = property!.toJson();
    }
    if (rentingDuration != null) {
      data['renting_duration'] = rentingDuration!.toJson();
    }
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
    return data;
  }
}

class Prrs {
  int? id;
  String? requirement;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? property;

  Prrs(
      {this.id,
      this.requirement,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.property});

  Prrs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requirement = json['requirement'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['requirement'] = requirement;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['property'] = property;
    return data;
  }
}

class Rdos {
  int? id;
  int? timeInNumber;
  String? timeInText;
  String? createdAt;
  String? updatedAt;
  int? property;

  Rdos(
      {this.id,
      this.timeInNumber,
      this.timeInText,
      this.createdAt,
      this.updatedAt,
      this.property});

  Rdos.fromJson(Map<String, dynamic> json) {
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

class MyPaymentCard {
  int? id;
  String? accountNumber;
  String? bankName;
  String? cardHolderName;
  dynamic cardExpiry;
  dynamic cardCvv;
  String? createdAt;
  String? updatedAt;
  int? user;

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
  String? mobileNumber;
  String? mobileHolderName;
  String? mobileNetwork;
  String? createdAt;
  String? updatedAt;
  int? user;

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
  int? id;
  int? user;
  int? renting;
  bool? rentingRequestConfirmed;
  String? rentingStatus;
  String? confirmedAt;
  String? startedAt;
  dynamic canceledAt;
  String? createdAt;
  String? updatedAt;

  RentingStatus(
      {this.id,
      this.user,
      this.renting,
      this.rentingRequestConfirmed,
      this.rentingStatus,
      this.confirmedAt,
      this.startedAt,
      this.canceledAt,
      this.createdAt,
      this.updatedAt});

  RentingStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    renting = json['renting'];
    rentingRequestConfirmed = json['renting_request_confirmed'];
    rentingStatus = json['renting_status'];
    confirmedAt = json['confirmed_at'];
    startedAt = json['started_at'];
    canceledAt = json['canceled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['renting'] = renting;
    data['renting_request_confirmed'] = rentingRequestConfirmed;
    data['renting_status'] = rentingStatus;
    data['confirmed_at'] = confirmedAt;
    data['started_at'] = startedAt;
    data['canceled_at'] = canceledAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
