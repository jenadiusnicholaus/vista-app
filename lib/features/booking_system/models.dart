class MyBookingModel {
  int? id;
  String? checkIn;
  String? checkOut;
  int? totalGuest;
  String? totalPrice;
  int? adult;
  int? children;
  String? createdAt;

  MyBookingModel(
      {this.id,
      this.checkIn,
      this.checkOut,
      this.totalGuest,
      this.totalPrice,
      this.adult,
      this.children,
      this.createdAt});

  MyBookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    totalGuest = json['total_guest'];
    totalPrice = json['total_price'];
    adult = json['adult'];
    children = json['children'];
    createdAt = json['created_at'];
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
    data['created_at'] = createdAt;
    return data;
  }
}
