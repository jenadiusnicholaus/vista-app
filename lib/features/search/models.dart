class SupportedRegionsModel {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;

  SupportedRegionsModel({this.count, this.next, this.previous, this.results});

  SupportedRegionsModel.fromJson(Map<String, dynamic> json) {
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
  String? regionName;
  bool? isCountry;
  bool? isPublished;
  String? slug;
  String? country;
  String? lat;
  String? lon;
  String? addressCode;
  String? state;
  String? city;
  String? createdAt;
  String? updatedAt;
  dynamic image;
  dynamic totalProperties;

  Results(
      {this.id,
      this.regionName,
      this.isCountry,
      this.isPublished,
      this.slug,
      this.country,
      this.lat,
      this.lon,
      this.addressCode,
      this.state,
      this.city,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.totalProperties});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionName = json['region_name'];
    isCountry = json['is_country'];
    isPublished = json['is_published'];
    slug = json['slug'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    addressCode = json['address_code'];
    state = json['state'];
    city = json['city'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    totalProperties = json['total_properties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['region_name'] = regionName;
    data['is_country'] = isCountry;
    data['is_published'] = isPublished;
    data['slug'] = slug;
    data['country'] = country;
    data['lat'] = lat;
    data['lon'] = lon;
    data['address_code'] = addressCode;
    data['state'] = state;
    data['city'] = city;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    data['total_properties'] = totalProperties;
    return data;
  }
}
