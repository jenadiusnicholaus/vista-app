class PropertyDetailsModel {
  String? name;
  Category? category;
  String? price;
  String? currency;
  String? period;
  String? description;
  String? address;
  String? city;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  String? image;
  Host? host;
  bool? availabilityStatus;
  bool? publicationStatus;
  List<Images>? images;
  List<Facilities>? facilities;
  List<Reviews>? reviews;
  List<Amenities>? amenities;
  String? createdAt;
  String? updatedAt;

  PropertyDetailsModel(
      {this.name,
      this.category,
      this.price,
      this.currency,
      this.period,
      this.description,
      this.address,
      this.city,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.image,
      this.host,
      this.availabilityStatus,
      this.publicationStatus,
      this.images,
      this.facilities,
      this.reviews,
      this.amenities,
      this.createdAt,
      this.updatedAt});

  PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    price = json['price'];
    currency = json['currency'];
    period = json['period'];
    description = json['description'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
    availabilityStatus = json['availability_status'];
    publicationStatus = json['publication_status'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(new Facilities.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(new Amenities.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['period'] = this.period;
    data['description'] = this.description;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    if (this.host != null) {
      data['host'] = this.host!.toJson();
    }
    data['availability_status'] = this.availabilityStatus;
    data['publication_status'] = this.publicationStatus;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.facilities != null) {
      data['facilities'] = this.facilities!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  dynamic icon;
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['property_count'] = this.propertyCount;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  dynamic lastLogin;
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
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['is_active'] = this.isActive;
    data['phone_is_verified'] = this.phoneIsVerified;
    data['last_login'] = this.lastLogin;
    data['date_joined'] = this.dateJoined;
    data['user_profile_pic'] = this.userProfilePic;
    return data;
  }
}

class Images {
  int? id;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? property;

  Images({this.id, this.image, this.createdAt, this.updatedAt, this.property});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['property'] = this.property;
    return data;
  }
}

class Facilities {
  int? id;
  String? description;
  String? facility;
  String? createdAt;
  String? updatedAt;
  int? property;

  Facilities(
      {this.id,
      this.description,
      this.facility,
      this.createdAt,
      this.updatedAt,
      this.property});

  Facilities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    facility = json['facility'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['facility'] = this.facility;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['property'] = this.property;
    return data;
  }
}

class Reviews {
  int? id;
  User? user;
  double? rating;
  String? comment;
  String? date;
  int? property;

  Reviews(
      {this.id,
      this.user,
      this.rating,
      this.comment,
      this.date,
      this.property});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['date'] = this.date;
    data['property'] = this.property;
    return data;
  }
}

class Amenities {
  int? id;
  String? name;
  String? description;
  bool? isAvailable;
  String? createdAt;
  String? updatedAt;
  int? property;

  Amenities(
      {this.id,
      this.name,
      this.description,
      this.isAvailable,
      this.createdAt,
      this.updatedAt,
      this.property});

  Amenities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isAvailable = json['is_available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['is_available'] = this.isAvailable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['property'] = this.property;
    return data;
  }
}
