import '../../../shared/models.dart';

class BookingRequestModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<MyRequestResults>? results;

  BookingRequestModel({this.count, this.next, this.previous, this.results});

  BookingRequestModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <MyRequestResults>[];
      json['results'].forEach((v) {
        results!.add(MyRequestResults.fromJson(v));
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

class MyRequestResults {
  int? id;
  String? checkIn;
  String? checkOut;
  int? totalGuest;
  String? totalPrice;
  int? adult;
  int? children;
  MyAddress? myAddress;
  MyPaymentCard? myPaymentCard;
  MyMwPayment? myMwPayment;
  MyBookingStatus? myBookingStatus;
  Property? property;

  MyRequestResults(
      {this.id,
      this.checkIn,
      this.checkOut,
      this.totalGuest,
      this.totalPrice,
      this.adult,
      this.children,
      this.myAddress,
      this.myPaymentCard,
      this.myMwPayment,
      this.myBookingStatus,
      this.property});

  MyRequestResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    totalGuest = json['total_guest'];
    totalPrice = json['total_price'];
    adult = json['adult'];
    children = json['children'];
    myAddress = json['my_address'] != null
        ? MyAddress.fromJson(json['my_address'])
        : null;
    myPaymentCard = json['my_payment_card'] != null
        ? MyPaymentCard.fromJson(json['my_payment_card'])
        : null;
    myMwPayment = json['my_mw_payment'] != null
        ? MyMwPayment.fromJson(json['my_mw_payment'])
        : null;
    myBookingStatus = json['my_booking_status'] != null
        ? MyBookingStatus.fromJson(json['my_booking_status'])
        : null;
    property =
        json['property'] != null ? Property.fromJson(json['property']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['total_guest'] = totalGuest;
    data['total_price'] = totalPrice;
    data['adult'] = adult;
    data['children'] = children;
    if (myAddress != null) {
      data['my_address'] = myAddress!.toJson();
    }
    if (myPaymentCard != null) {
      data['my_payment_card'] = myPaymentCard!.toJson();
    }
    if (myMwPayment != null) {
      data['my_mw_payment'] = myMwPayment!.toJson();
    }
    if (myBookingStatus != null) {
      data['my_booking_status'] = myBookingStatus!.toJson();
    }
    if (property != null) {
      data['property'] = property!.toJson();
    }
    return data;
  }
}

class MyAddress {
  String? address;
  String? city;
  String? state;
  String? country;
  dynamic latitude;
  dynamic longitude;
  dynamic user;

  MyAddress(
      {this.address,
      this.city,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.user});

  MyAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['user'] = user;
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

class MyBookingStatus {
  int? id;
  int? user;
  int? booking;
  bool? confirmed;
  bool? completed;
  bool? canceled;
  String? confirmedAt;
  dynamic completedAt;
  dynamic canceledAt;
  String? createdAt;
  String? updatedAt;

  MyBookingStatus(
      {this.id,
      this.user,
      this.booking,
      this.confirmed,
      this.completed,
      this.canceled,
      this.confirmedAt,
      this.completedAt,
      this.canceledAt,
      this.createdAt,
      this.updatedAt});

  MyBookingStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    booking = json['booking'];
    confirmed = json['confirmed'];
    completed = json['completed'];
    canceled = json['canceled'];
    confirmedAt = json['confirmed_at'];
    completedAt = json['completed_at'];
    canceledAt = json['canceled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['booking'] = booking;
    data['confirmed'] = confirmed;
    data['completed'] = completed;
    data['canceled'] = canceled;
    data['confirmed_at'] = confirmedAt;
    data['completed_at'] = completedAt;
    data['canceled_at'] = canceledAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
