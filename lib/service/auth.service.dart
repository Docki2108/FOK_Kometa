import 'dart:async';
import 'dart:developer';

import 'package:fok_kometa/supabase.credentials.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static void _subscribeToUserScheme(User user) {
    var sub = Supabase.instance.client
        .channel('public:users:id=eq.${user.id}')
        .on(
            RealtimeListenTypes.postgresChanges,
            ChannelFilter(
                event: '*',
                schema: 'public',
                table: 'users',
                filter: 'id=eq.${user.id}'), (payload, [ref]) {
      print('payload ${payload.toString()}');
    });
    sub.subscribe();
  }

  static Future<void> signUp(
      {required String email, required String password}) async {
    var response = await SupabaseCredentials.supabaseClient.auth
        .signUp(email: email, password: password);

    if (response.user != null) {
      _subscribeToUserScheme(response.user!);

      var userMail = response.user!;
      log("Sign successful: $userMail");
    } else {
      log("Sign error!");
    }
  }

  static FutureOr<dynamic> signIn(
      {required String email, required String password}) async {
    try {
      var response = await SupabaseCredentials.supabaseClient.auth
          .signInWithPassword(email: email, password: password);

      if (response.user != null) {
        _subscribeToUserScheme(response.user!);

        var userMail = response.user!;
        log("Sign successful: $userMail");
      } else {
        log("Sign error!");
      }

      return response.user!;
    } catch (e) {
      return "Ошипка";
    }
  }
}
