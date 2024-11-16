import 'package:vista/shared/models.dart';

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
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
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
