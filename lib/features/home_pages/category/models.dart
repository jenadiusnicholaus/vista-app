class PropertyCategoriesModel {
  int? count;
  String? next;
  Null? previous;
  List<CResults>? results;

  PropertyCategoriesModel({this.count, this.next, this.previous, this.results});

  PropertyCategoriesModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <CResults>[];
      json['results'].forEach((v) {
        results!.add(CResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CResults {
  int? id;
  String? name;
  Null? icon;
  String? description;
  String? createdAt;
  bool? published;
  String? updatedAt;

  CResults(
      {this.id,
      this.name,
      this.icon,
      this.description,
      this.createdAt,
      this.published,
      this.updatedAt});

  CResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    description = json['description'];
    createdAt = json['created_at'];
    published = json['published'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['published'] = this.published;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
