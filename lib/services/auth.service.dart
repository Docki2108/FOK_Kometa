import 'dart:async';
import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase.credentials.dart';

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
      log('payload ${payload.toString()}');
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
      log("Регистрация прошла успешно: $userMail");
    } else {
      log("Ошибка регистрации!");
    }
  }

  static FutureOr<dynamic> signIn(
      {required String email, required String password}) async {
    try {
      var response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      if (response.user != null) {
        _subscribeToUserScheme(response.user!);

        var userMail = response.user!;
        log("Авторизация прошла успешно: $userMail");
      } else {
        log("Ошибка авторизации!");
      }

      return response.user!;
    } catch (e) {
      return "Ошибка авторизации";
    }
  }
}
