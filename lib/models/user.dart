import 'personal_data.dart';

class User {
  static User? _context;
  int id;
  String email;
  String role;
  PersonalData personalData;

  User._(
      {required this.id,
      required this.email,
      required this.role,
      required this.personalData});

  void logout() => _context = null;

  factory User.get() {
    if (_context == null) {
      throw UnimplementedError("используй User.fromJson");
    } else {
      return _context!;
    }
  }

  static bool isAnon() {
    return _context == null;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return _context = User._(
      id: json['id_user'],
      email: json['email'],
      role: json['role'],
      personalData: PersonalData.fromJson(json['personal_data']),
    );
  }
}
