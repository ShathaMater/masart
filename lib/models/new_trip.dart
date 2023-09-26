class NewTrip {
  late String? id;

  String? titleAr;
  String? descriptionAr;
  String? categoryAr;
  String? companyAr;
  String? companyId;
  int? companyRate;
  String? locationAr;
  String? imagePath;
  String? price;
  String? startDate;
  String? endDate;
  String? duration;
  bool? isFav;
  String? timestamp;
  int? persons = 1;

  NewTrip({
    this.id,
    this.imagePath,
    this.isFav,
    this.price,
    this.categoryAr,
    this.companyAr,
    this.locationAr,
    this.companyRate,
    this.descriptionAr,
    this.duration,
    this.endDate,
    this.startDate,
    this.titleAr,
    this.timestamp,
    this.companyId,
    this.persons,
  });

  factory NewTrip.fromJson(Map<String, dynamic> data) {
    return NewTrip(
      id: data['id'],
      titleAr: data['titleAr'],
      descriptionAr: data['descriptionAr'],
      price: data['price'],
      categoryAr: data['categoryAr'],
      locationAr: data['locationAr'],
      companyAr: data['companyAr'],
      companyRate: data['companyRate'],
      companyId: data['companyId'],
      duration: data['duration'],
      endDate: data['endDate'],
      startDate: data['startDate'],
      imagePath: data['imagePath'],
      isFav: data['isFav'] ?? false,
      timestamp: data['timestamp'],
      persons: data['persons'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "titleAr": titleAr,
        'companyId': companyId,
        "descriptionAr": descriptionAr,
        'categoryAr': categoryAr,
        'companyAr': companyAr,
        'companyRate': companyRate,
        'locationAr': locationAr,
        'imagePath': imagePath,
        'price': price,
        'startDate': startDate,
        'endDate': endDate,
        'duration': duration,
        'timestamp': timestamp,
        'isFav': isFav,
        'persons': persons ?? 1,
      };

  static List newTrips = [
    NewTrip(
      id: '1',
      titleAr: 'تركيا',
      descriptionAr:
          'الاقامة في فندق خمس نجوم مواصلات مؤمنة من والى الفندق متوفر مرشد سياحي طوال فترة الرحلة وجبة افطار يوميا شامل تنسيق معبر رفح شامل حجز تذاكر الطيران شامل تأشيرة الدخول',
      duration: '7',
      startDate: '20/07/2023',
      endDate: '26/07/2023',
      price: '1000',
      companyAr: 'شركة حنيف',
      companyRate: 5,
      imagePath: 'assets/images/test.png',
      isFav: false,
      categoryAr: 'سياحية',
      locationAr: 'تركيا',
      persons: 1,
    ),
    NewTrip(
      id: '2',
      titleAr: 'ماليزيا',
      descriptionAr:
          '"الاقامة في فندق اربع نجوم مواصلات مؤمنة من والى الفندق متوفر مرشد علمي لزيارة الجامعات الماليزيا زيادة الفنادق الاثرية وجبة افطار يوميا شامل تنسيق معبر رفح شامل حجز تذاكر الطيران',
      duration: '10',
      startDate: '30/07/2023',
      endDate: '10/08/2023',
      price: '1500',
      companyAr: 'شركة الزعيم',
      companyRate: 5,
      imagePath: 'assets/images/test.png',
      isFav: false,
      categoryAr: 'سياحية',
      locationAr: 'تركيا',
      persons: 1,
    ),
    NewTrip(
      id: '3',
      titleAr: 'مصر',
      descriptionAr:
          'الاقامة في فندق ثلاث نجوم مواصلات مؤمنة الى الفندق زيارة الاهرام وبرج القاهرة والمتحف الكبير وجبة افطار يوميا شامل تنسيق معبر رفح',
      duration: '10',
      startDate: '30/08/2023',
      endDate: '26/07/2023',
      price: '700',
      companyAr: 'شركة اللد',
      companyRate: 4,
      imagePath: 'assets/images/test.png',
      isFav: false,
      categoryAr: 'علاجية',
      locationAr: 'مصر',
      persons: 1,
    ),
    NewTrip(
      id: '4',
      titleAr: 'الاردن',
      descriptionAr:
          'الاقامة في فندق ثلاث نجوم مواصلات مؤمنة الى الفندق زيارة البحر الميت وجبة افطار يوميا شامل تنسيق معبر رفح شامل حجز تذاكر الطيران الحصول على عدم ممانعة',
      duration: '7',
      startDate: '20/07/2023',
      endDate: '26/07/2023',
      price: '1400',
      companyAr: 'شركة اللد',
      companyRate: 4,
      imagePath: 'assets/images/test.png',
      isFav: false,
      categoryAr: 'علاجية',
      locationAr: 'الاردن',
      persons: 1,
    ),
    NewTrip(
      id: '5',
      titleAr: 'السعودية',
      descriptionAr:
          'الاقامة في فندق ثلاث نجوم مواصلات مؤمنة الى الفندق زيارة البحر الميت وجبة افطار يوميا شامل تنسيق معبر رفح شامل حجز تذاكر الطيران الحصول على عدم ممانعة',
      duration: '7',
      startDate: '01/09/2023',
      endDate: '01/10/2023',
      price: '1700',
      companyAr: 'شركة حنيف',
      companyRate: 5,
      imagePath: 'assets/images/test.png',
      isFav: false,
      categoryAr: 'دينية',
      locationAr: 'السعودية',
      persons: 1,
    ),
    NewTrip(
      id: '6',
      titleAr: 'السعودية',
      descriptionAr:
          'الاقامة في فندق ثلاث نجوم مواصلات مؤمنة الى الفندق زيارة البحر الميت وجبة افطار يوميا شامل تنسيق معبر رفح شامل حجز تذاكر الطيران الحصول على عدم ممانعة',
      duration: '7',
      startDate: '01/09/2023',
      endDate: '15/09/2023',
      price: '2000',
      companyAr: 'شركة حنيف',
      companyRate: 5,
      imagePath: 'assets/images/test.png',
      isFav: false,
      categoryAr: 'دينية',
      locationAr: 'السعودية',
      persons: 1,
    ),
    NewTrip(
      id: '7',
      titleAr: 'اسبانيا',
      descriptionAr:
          'الاقامة في فندق اربع نجوم مواصلات مؤمنة من والى الفندق متوفر مرشد علمي زيادة الاماكن الاثرية وجبة افطار يوميا شامل تنسيق معبر رفح شامل حجز تذاكر الطيران شامل تأشيرة الدخول',
      duration: '7',
      startDate: '01/10/2023',
      endDate: '06/10/2023',
      price: '1400',
      companyAr: 'شركة فجن',
      companyRate: 3,
      imagePath: 'assets/images/test.png',
      isFav: false,
      categoryAr: 'علمية',
      locationAr: 'اسبانيا',
      persons: 1,
    ),
    NewTrip(
      id: '8',
      titleAr: 'الصين',
      descriptionAr:
          'الاقامة في فندق خمس نجوم مواصلات مؤمنة من المطار الى الفندق متوفر مرشد علمي زيادة الفنادق الاثرية وجبة افطار يوميا شامل تنسيق معبر رفح شامل حجز تذاكر الطيران شامل تأشيرة الدخول',
      duration: '7',
      startDate: '01/10/2023',
      endDate: '06/10/2023',
      price: '٩٩٩',
      companyAr: 'شركة فجن',
      companyRate: 3,
      imagePath: 'assets/images/test.png',
      isFav: false,
      categoryAr: 'علمية',
      locationAr: 'الصين',
      persons: 1,
    ),
    NewTrip(
      id: '9',
      titleAr: 'الهند',
      descriptionAr:
          'الاقامة في فندق خمس نجوم مواصلات مؤمنة من المطار الى الفندق متوفر مرشد علمي زيادة الفنادق الاثرية وجبة افطار يوميا شامل تنسيق معبر رفح شامل حجز تذاكر الطيران شامل تأشيرة الدخول',
      duration: '15',
      startDate: '1/012/2023',
      endDate: '15/12/2023',
      price: '3000',
      companyAr: 'شركة اللد',
      companyRate: 4,
      imagePath: 'assets/images/test.png',
      isFav: false,
      categoryAr: 'سياحية',
      locationAr: 'الهند',
      persons: 1,
    ),
  ];
}
