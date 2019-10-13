import 'package:flutter/material.dart';
import 'package:recase/recase.dart';


//final String url = 'https://jsonplaceholder.typicode.com/users';
final String url = 'http://staging.vectolabs.com/getdata';
class UserDetails {
  final int id;
  final String name, price, quantity, created, updated, deleted, profileUrl;

  UserDetails({this.id, this.name, this.price, this.quantity, this.created, this.updated, this.deleted, this.profileUrl = 'https://assets.simplecast.com/assets/fallback/default-b7824fcd998f51baf0f0af359a72e760.png'});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['id'],
//      firstName: json['name'],
//      lastName: json['username'],
      name: json['brand'],
      price: json['price'],
      quantity: json['qty'],
      created: json['CreatedAt'],
      updated: json['UpdatedAt'],
      deleted: json['DeletedAt'],
    );
  }
}