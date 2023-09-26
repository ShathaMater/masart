class MostRated {
  late int? id;
  late String? imagePath;
  late bool? isFav;
  late int? rating;

  MostRated({
    this.id,
    this.imagePath,
    this.isFav,
    this.rating,
  });
}

var mostRated = [
  MostRated(
      id: 1, imagePath: 'assets/images/test.png', isFav: false, rating: 2),
  MostRated(
      id: 1, imagePath: 'assets/images/test.png', isFav: false, rating: 2),
  MostRated(id: 1, imagePath: 'assets/images/test.png', isFav: true, rating: 2),
  MostRated(
      id: 1, imagePath: 'assets/images/test.png', isFav: false, rating: 2),
];
