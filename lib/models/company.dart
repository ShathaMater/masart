class CompanyNew {
  String? id;
  String? companyName;
  String? email;
  String? companyAddress;
  String? phoneNumber;
  String? companyRate;
  String? timestamp;
  List<UserRating>? ratings;

  CompanyNew({
    this.id,
    this.companyName,
    this.email,
    this.companyAddress,
    this.phoneNumber,
    this.companyRate,
    this.timestamp,
    this.ratings,
  });

  factory CompanyNew.fromJson(Map<String, dynamic> json) {
    print(json);
    return CompanyNew(
      id: json["id"],
      companyName: json["company_name"],
      email: json["email"],
      companyAddress: json["Company_address"],
      phoneNumber: json["phone_number"],
      companyRate: json["company_rate"],
      timestamp: json['timestamp'].toString(),
      // ratings: List.from(json['ratings'].map((e) => UserRating.fromJson(json))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "email": email,
        "Company_address": companyAddress,
        "phone_number": phoneNumber,
        "company_rate": companyRate,
        'timestamp': timestamp,
      };
}

class UserRating {
  String userId;
  double rating;

  UserRating({
    required this.userId,
    required this.rating,
  });

  factory UserRating.fromJson(Map<String, dynamic> json) => UserRating(
        userId: json["userId"],
        rating: json["rating"],
      );
}

class Company {
  late int? id;
  late String? imagePath;
  late bool? isFav;
  late String? categoryId;
  late int? rating;
  late String? companyAr;
  late String? companyEn;
  late String? locationAr;
  late String? locationEn;

  Company({
    this.id,
    this.imagePath,
    this.isFav,
    this.categoryId,
    this.rating,
    this.companyAr,
    this.companyEn,
    this.locationAr,
    this.locationEn,
  });
}

var companies = [
  Company(
    id: 1,
    imagePath: 'assets/images/test.png',
    isFav: false,
    categoryId: '1',
    rating: 2,
    companyAr: 'شركة المسافر',
    locationAr: 'لندن',
  ),
  Company(
    id: 1,
    imagePath: 'assets/images/test.png',
    isFav: false,
    categoryId: '1',
    rating: 2,
    companyAr: 'شركة المسافر',
    locationAr: 'لندن',
  ),
  Company(
    id: 1,
    imagePath: 'assets/images/test.png',
    isFav: false,
    categoryId: '1',
    rating: 2,
    companyAr: 'شركة المسافر',
    locationAr: 'لندن',
  ),
  Company(
    id: 1,
    imagePath: 'assets/images/test.png',
    isFav: false,
    categoryId: '1',
    rating: 2,
    companyAr: 'شركة المسافر',
    locationAr: 'لندن',
  ),
];
