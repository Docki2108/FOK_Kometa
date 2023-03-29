// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  User supa_user;
  Role role;

  UserModel({
    required this.supa_user,
    required this.role,
  });

  UserModel copyWith({
    User? supa_user,
    Role? role,
  }) {
    return UserModel(
      supa_user: supa_user ?? this.supa_user,
      role: role ?? this.role,
    );
  }

  @override
  String toString() => 'UserModel(supa_user: $supa_user, role: $role)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.supa_user == supa_user && other.role == role;
  }

  @override
  int get hashCode => supa_user.hashCode ^ role.hashCode;
}

abstract class Role {
  String name;
  Role({
    required this.name,
  });
}

class Manager implements Role {
  @override
  String name;
  Manager({
    required this.name,
  });
}

class Client implements Role {
  @override
  String name;
  Client({
    required this.name,
  });
}
