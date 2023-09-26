class Onboarding {
  late int? id;
  late String? titleEn;
  late String? titleAr;
  late String? subTitleEn;
  late String? subTitleAr;
  late String? imagePathEn;
  late String? bulitPoints;
  Onboarding({
    this.id,
    this.titleEn,
    this.titleAr,
    this.subTitleEn,
    this.subTitleAr,
    this.imagePathEn,
    this.bulitPoints,
  });
}

var onBoardingData = [
  Onboarding(
    id: 1,
    titleAr: 'احجز رحلتك الآن',
    subTitleAr: 'كل ماتحتاجه تجده بسهولة وراحة',
    imagePathEn: 'assets/images/onboard_img1.png',
  ),
  Onboarding(
    id: 1,
    titleAr: 'سارع بالاستمتاع',
    subTitleAr: 'مسار مريح وحسب رغبتك وحاجاتك',
    imagePathEn: 'assets/images/onboard_img2.png',
  ),
  Onboarding(
    id: 1,
    titleAr: 'تتبع مسار رحلتك بسهولة',
    subTitleAr: 'لأجلك صنعنا التطبيق استمتع برحلتك',
    imagePathEn: 'assets/images/onboard_img3.png',
  ),
];
