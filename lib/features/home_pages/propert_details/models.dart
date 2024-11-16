import '../../../shared/models.dart';

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
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(Facilities.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(Amenities.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (facilities != null) {
      data['facilities'] = facilities!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (amenities != null) {
      data['amenities'] = amenities!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['property'] = property;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['description'] = description;
    data['facility'] = facility;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['property'] = property;
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['rating'] = rating;
    data['comment'] = comment;
    data['date'] = date;
    data['property'] = property;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['is_available'] = isAvailable;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['property'] = property;
    return data;
  }
}
