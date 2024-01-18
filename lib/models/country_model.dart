// To parse this JSON data, do
import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
    final String country;
    final String phoneCode;

    Country({
        required this.country,
        required this.phoneCode,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        country: json["country"],
        phoneCode: json["phoneCode"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "phoneCode": phoneCode,
    };
}
