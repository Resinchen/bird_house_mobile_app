class Address {
  String houseNumber;
  String street;
  String longHouse;
  String city;
  String longCity;
  String country;

  Address(
      {this.houseNumber,
      this.street,
      this.longHouse,
      this.city,
      this.country,
      this.longCity});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        houseNumber: json['house_number'] ?? '',
        street: json['road'] ?? '',
        longHouse: '${json['house_number'] ?? ''} ${json['road'] ?? ''}',
        city: json['city'] ?? json['county'] ?? '',
        longCity: json['display_name'] ?? '',
        country: json['country'] ?? '');
  }
}
