class PropertListModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  PropertListModel({this.count, this.next, this.previous, this.results});

  PropertListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  Host? host;
  Category? category;
  String? name;
  String? price;
  String? currency;
  String? period;
  String? description;
  String? address;
  String? businessType;
  String? city;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  String? image;
  bool? availabilityStatus;
  bool? publicationStatus;
  String? createdAt;
  String? updatedAt;
  bool? isMyFavorite;
  dynamic rating;

  Results(
      {this.id,
      this.host,
      this.category,
      this.name,
      this.price,
      this.currency,
      this.period,
      this.description,
      this.address,
      this.businessType,
      this.city,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.image,
      this.availabilityStatus,
      this.publicationStatus,
      this.createdAt,
      this.updatedAt,
      this.isMyFavorite,
      this.rating});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    name = json['name'];
    price = json['price'];
    currency = json['currency'];
    period = json['period'];
    description = json['description'];
    address = json['address'];
    businessType = json['business_type'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    availabilityStatus = json['availability_status'];
    publicationStatus = json['publication_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isMyFavorite = json['is_my_favorite'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (host != null) {
      data['host'] = host!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['name'] = name;
    data['price'] = price;
    data['currency'] = currency;
    data['period'] = period;
    data['description'] = description;
    data['address'] = address;
    data['business_type'] = businessType;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['image'] = image;
    data['availability_status'] = availabilityStatus;
    data['publication_status'] = publicationStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_my_favorite'] = isMyFavorite;
    data['rating'] = rating;
    return data;
  }
}

class Host {
  int? id;
  User? user;
  int? propertyCount;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;

  Host(
      {this.id,
      this.user,
      this.propertyCount,
      this.isVerified,
      this.createdAt,
      this.updatedAt});

  Host.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    propertyCount = json['property_count'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['property_count'] = propertyCount;
    data['is_verified'] = isVerified;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? dateOfBirth;
  bool? isActive;
  bool? phoneIsVerified;
  Null? lastLogin;
  String? dateJoined;
  String? userProfilePic;

  User(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.dateOfBirth,
      this.isActive,
      this.phoneIsVerified,
      this.lastLogin,
      this.dateJoined,
      this.userProfilePic});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    isActive = json['is_active'];
    phoneIsVerified = json['phone_is_verified'];
    lastLogin = json['last_login'];
    dateJoined = json['date_joined'];
    userProfilePic = json['user_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['is_active'] = isActive;
    data['phone_is_verified'] = phoneIsVerified;
    data['last_login'] = lastLogin;
    data['date_joined'] = dateJoined;
    data['user_profile_pic'] = userProfilePic;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  Null? icon;
  String? description;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.name,
      this.icon,
      this.description,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
