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
        results!.add(Results.fromJson(v));
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

class Results {
  int? id;
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
  String? createdAt;
  String? updatedAt;
  bool? isMyFavorite;
  String? businessType;
  double? rating;
  int? supportedGeoRegion;
  String? contractDraft;
  BORpolicy? bORpolicy;
  List<Prrs>? prrs;
  List<Rdos>? rdos;

  Results(
      {this.id,
      this.name,
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
      this.createdAt,
      this.updatedAt,
      this.isMyFavorite,
      this.businessType,
      this.rating,
      this.supportedGeoRegion,
      this.contractDraft,
      this.bORpolicy,
      this.prrs,
      this.rdos});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
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
    host = json['host'] != null ? Host.fromJson(json['host']) : null;
    availabilityStatus = json['availability_status'];
    publicationStatus = json['publication_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isMyFavorite = json['is_my_favorite'];
    businessType = json['business_type'];
    rating = json['rating'];
    supportedGeoRegion = json['supported_geo_region'];
    contractDraft = json['contract_draft'];
    bORpolicy = json['BORpolicy'] != null
        ? BORpolicy.fromJson(json['BORpolicy'])
        : null;
    if (json['prrs'] != null) {
      prrs = <Prrs>[];
      json['prrs'].forEach((v) {
        prrs!.add(Prrs.fromJson(v));
      });
    }
    if (json['rdos'] != null) {
      rdos = <Rdos>[];
      json['rdos'].forEach((v) {
        rdos!.add(Rdos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['price'] = price;
    data['currency'] = currency;
    data['period'] = period;
    data['description'] = description;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['image'] = image;
    if (host != null) {
      data['host'] = host!.toJson();
    }
    data['availability_status'] = availabilityStatus;
    data['publication_status'] = publicationStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_my_favorite'] = isMyFavorite;
    data['business_type'] = businessType;
    data['rating'] = rating;
    data['supported_geo_region'] = supportedGeoRegion;
    data['contract_draft'] = contractDraft;
    if (bORpolicy != null) {
      data['BORpolicy'] = bORpolicy!.toJson();
    }
    if (prrs != null) {
      data['prrs'] = prrs!.map((v) => v.toJson()).toList();
    }
    if (rdos != null) {
      data['rdos'] = rdos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  dynamic icon;
  String? description;
  String? createdAt;
  bool? published;
  String? updatedAt;

  Category(
      {this.id,
      this.name,
      this.icon,
      this.description,
      this.createdAt,
      this.published,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    description = json['description'];
    createdAt = json['created_at'];
    published = json['published'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['published'] = published;
    data['updated_at'] = updatedAt;
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    propertyCount = json['property_count'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class BORpolicy {
  int? id;
  String? title;
  String? policy;
  bool? published;
  String? createdAt;
  String? updatedAt;
  int? property;
  int? host;

  BORpolicy(
      {this.id,
      this.title,
      this.policy,
      this.published,
      this.createdAt,
      this.updatedAt,
      this.property,
      this.host});

  BORpolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    policy = json['policy'];
    published = json['published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    property = json['property'];
    host = json['host'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['policy'] = policy;
    data['published'] = published;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['property'] = property;
    data['host'] = host;
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
