class Discounts {
  late int? id;
  late String? imagePath;
  late double? price;
  late String? categoryAr;
  late String? categoryEn;
  late int? rating;
  late String? companyAr;
  late String? companyEn;
  late String? locationAr;
  late String? locationEn;
  late String? date;
  late String? discount;

  Discounts(
      {this.id,
      this.imagePath,
      this.price,
      this.categoryAr,
      this.categoryEn,
      this.rating,
      this.companyAr,
      this.companyEn,
      this.locationAr,
      this.locationEn,
      this.date,
      this.discount});
}

var discounts = [
  Discounts(
    id: 1,
    imagePath: 'assets/images/test.png',
    price: 0.5,
    categoryAr: 'سياحية',
    rating: 2,
    companyAr: 'شركة المسافر',
    locationAr: 'لندن',
    date: '22/5/2023',
    discount: '30%',
  ),
  Discounts(
    id: 1,
    imagePath: 'assets/images/test.png',
    price: 0.5,
    categoryAr: 'سياحية',
    rating: 2,
    companyAr: 'شركة المسافر',
    locationAr: 'لندن',
    date: '22/5/2023',
    discount: '30%',
  ),
  Discounts(
    id: 1,
    imagePath: 'assets/images/test.png',
    price: 0.5,
    categoryAr: 'سياحية',
    rating: 2,
    companyAr: 'شركة المسافر',
    locationAr: 'لندن',
    date: '22/5/2023',
    discount: '30%',
  ),
];
