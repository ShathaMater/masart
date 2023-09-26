class Categories {
  late int? id;
  late String? imagePath;
  late String? titleAr;
  late String? titleEn;

  Categories({
    this.id,
    this.imagePath,
    this.titleAr,
    this.titleEn,
  });
}

var categories = [
  Categories(
      id: 1, imagePath: 'assets/images/test.png', titleAr: 'رحلات سياحية'),
  Categories(
      id: 2, imagePath: 'assets/images/test.png', titleAr: 'رحلات دينية'),
  Categories(
      id: 3, imagePath: 'assets/images/test.png', titleAr: 'رحلات علاجية'),
  Categories(
      id: 4, imagePath: 'assets/images/test.png', titleAr: 'رحلات علمية'),
];
