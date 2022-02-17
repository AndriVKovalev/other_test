//import 'dart:convert';


class Company {
  final String companyname;
  final String catchPhrase;
  final String bs;

  Company({
    required this.companyname,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => _companyFromJson(json);
}

Company _companyFromJson(Map<String, dynamic> json) => Company(
      companyname: json['name'],
      catchPhrase: json['catchPhrase'],
      bs : json['bs'],
);


class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  Map address;
  Map  company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: json['address'],
      company: json['company'],

    );
  }
}

class Address{
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
    );
  }
}

