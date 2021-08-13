class Reservation {
  String from;
  String to;
  String departure;
  String destination;
  String time;
  String departureDate;
  String destinationDate;
  String departureHour;
  String destinationHour;
  String price;
  String flight;
  String typeClass;
  bool isExpanded;

  Reservation({
    required this.from,
    required this.to,
    required this.departure,
    required this.destination,
    required this.time,
    required this.departureDate,
    required this.destinationDate,
    required this.departureHour,
    required this.destinationHour,
    required this.price,
    required this.flight,
    required this.typeClass,
    required this.isExpanded,
  });
}
