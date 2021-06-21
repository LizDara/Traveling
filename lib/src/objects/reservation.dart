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
    this.from,
    this.to,
    this.departure,
    this.destination,
    this.time,
    this.departureDate,
    this.destinationDate,
    this.departureHour,
    this.destinationHour,
    this.price,
    this.flight,
    this.typeClass,
    this.isExpanded,
  });
}
