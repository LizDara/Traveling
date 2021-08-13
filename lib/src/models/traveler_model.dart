import 'dart:convert';

List<Traveler> travelerFromJson(String str) =>
    List<Traveler>.from(json.decode(str).map((x) => Traveler.fromJson(x)));

String travelerToJson(List<Traveler> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Traveler {
  Traveler({
    this.id,
    this.dateOfBirth,
    this.name,
    this.gender,
    this.contact,
  });

  String? id;
  String? dateOfBirth;
  Name? name;
  String? gender;
  Contact? contact;

  factory Traveler.fromJson(Map<String, dynamic> json) => Traveler(
        id: json["id"],
        dateOfBirth: json["dateOfBirth"],
        name: Name.fromJson(json["name"]),
        gender: json["gender"],
        contact: Contact.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateOfBirth": dateOfBirth,
        "name": name!.toJson(),
        "gender": gender,
        "contact": contact!.toJson(),
      };
}

class Contact {
  Contact({
    this.emailAddress,
    this.phones,
  });

  String? emailAddress;
  List<Phone>? phones;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        emailAddress: json["emailAddress"],
        phones: List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "phones": List<dynamic>.from(phones!.map((x) => x.toJson())),
      };
}

class Phone {
  Phone({
    this.deviceType,
    this.number,
  });

  String? deviceType;
  String? number;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        deviceType: json["deviceType"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "deviceType": deviceType,
        "number": number,
      };
}

class Name {
  Name({
    this.firstName,
    this.lastName,
  });

  String? firstName;
  String? lastName;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
      };
}
