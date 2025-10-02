class CompanyModel {
  String companyId;
  String name;
  String domain;
  int reviewCount;
  double trustScore;
  double rating;
  List<Category> categories;
  String website;

  CompanyModel({
    required this.companyId,
    required this.name,
    required this.domain,
    required this.reviewCount,
    required this.trustScore,
    required this.rating,
    required this.categories,
    required this.website,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    companyId: json["company_id"],
    name: json["name"],
    domain: json["domain"],
    reviewCount: json["review_count"],
    trustScore: json["trust_score"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    categories: List<Category>.from(json["categories"].map((cat) => Category.fromJson(cat))),
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "company_id": companyId,
    "name": name,
    "domain": domain,
    "review_count": reviewCount,
    "trust_score": trustScore,
    "rating": rating,
    "categories": List<dynamic>.from(categories.map((cat) => cat.toJson())),
    "website": website,
  };
}

class Category {
  String id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
