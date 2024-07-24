class MyBookingModel {
  int? id;
  dynamic checkIn;
  dynamic checkOut;
  dynamic totalGuest;
  dynamic totalPrice;
  dynamic adult;
  dynamic children;
  MyAddress? myAddress;
  MyPaymentCard? myPaymentCard;
  MyMwPayment? myMwPayment;

  MyBookingModel(
      {this.id,
      this.checkIn,
      this.checkOut,
      this.totalGuest,
      this.totalPrice,
      this.adult,
      this.children,
      this.myAddress,
      this.myPaymentCard,
      this.myMwPayment});

  MyBookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    totalGuest = json['total_guest'];
    totalPrice = json['total_price'];
    adult = json['adult'];
    children = json['children'];
    myAddress = json['my_address'] != null
        ? new MyAddress.fromJson(json['my_address'])
        : null;
    myPaymentCard = json['my_payment_card'] != null
        ? new MyPaymentCard.fromJson(json['my_payment_card'])
        : null;
    myMwPayment = json['my_mw_payment'] != null
        ? new MyMwPayment.fromJson(json['my_mw_payment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}

class MyAddress {
  dynamic id;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic latitude;
  dynamic longitude;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic user;

  MyAddress(
      {this.id,
      this.address,
      this.city,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.user});

  MyAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user;
    return data;
  }
}

class MyPaymentCard {
  dynamic id;
  String? accountNumber;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  dynamic id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
