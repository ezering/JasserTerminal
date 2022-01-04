import 'package:jasser_terminal/models/shop.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final List<Shop> shops;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.shops,
  });


}
