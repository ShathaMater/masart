class Booking {
  late int? id;
  late String? locationAr;
  late String? locationEn;
  late String? price;
  late String? date;
  late String? quantity;

  Booking({
    this.id,
    this.locationAr,
    this.locationEn,
    this.price,
    this.date,
    this.quantity,
  });
}

var bookings = [
  Booking(
    id: 1,
    locationAr: 'لندن',
    price: '1500',
    date: '22/12/2022',
    quantity: '1',
  ),
  Booking(
    id: 1,
    locationAr: 'لندن',
    price: '1500',
    date: '22/12/2022',
    quantity: '1',
  ),
];
