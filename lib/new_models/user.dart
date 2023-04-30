import 'personal_data.dart';

class User {
  final int id;
  final String email;
  final String role;
  final PersonalData personalData;

  User(
      {required this.id,
      required this.email,
      required this.role,
      required this.personalData});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id_user'],
      email: json['email'],
      role: json['role'],
      personalData: PersonalData.fromJson(json['personal_data']),
    );
  }
}
