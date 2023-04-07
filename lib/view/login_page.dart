import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fok_kometa/service/auth.service.dart';
import 'package:fok_kometa/theme/theme.dart';
import 'package:fok_kometa/view/menu_page.dart';

import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class login_page extends StatelessWidget {
  const login_page({super.key});
  static const String route = "/login_page";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: const LoginPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FocusNode loginNode;
  late FocusNode passwordNode;
  late FocusNode btn_contNode;
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _loginformKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();
  final _fokformKey = GlobalKey<FormState>();

  late String _email;
  late String _password;
  bool _isAllExist = false;
  bool _isPasswordExist = false;
  bool _isEmailExist = false;

  bool light0 = true;

  @override
  void initState() {
    loginNode = FocusNode();
    passwordNode = FocusNode();
    btn_contNode = FocusNode();
    super.initState();
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(menu_page.route);
      }
    });
  }

  @override
  void dispose() {
    loginNode.dispose();
    passwordNode.dispose();
    btn_contNode.dispose();

    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(
        //           "lib/theme/images/background/noisable-gradient-1-small.jpg"),
        //       fit: BoxFit.fill),
        // ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 80),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "lib/theme/images/background/icons-pic/dumbbell.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(40.0),
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          key: _fokformKey,
                          'ФОК Комета',
                          style: const TextStyle(
                            fontSize: 36,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 60,
                          child: TextFormField(
                            onChanged: (value1) => {
                              _checkEmail(value1),
                              value1 = passwordController.text.trim()
                            },
                            key: _loginformKey,
                            controller: loginController,
                            onEditingComplete: () => passwordNode.nextFocus(),
                            focusNode: loginNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              filled: true,
                              // fillColor: Colors.white,
                              // focusColor: Colors.brown,
                              prefixIcon: Icon(
                                Icons.account_circle_outlined,
                              ),
                              hintText: 'Почта',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 60,
                          child: TextFormField(
                            onChanged: (valuePassword) => {
                              _checkPassword(valuePassword),
                            },
                            key: _passwordformKey,
                            controller: passwordController,
                            obscureText: true,
                            focusNode: passwordNode,
                            onEditingComplete: () => btn_contNode.nextFocus(),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              filled: true,
                              //fillColor: Colors.white,
                              //focusColor: Colors.brown,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                              ),
                              hintText: 'Пароль',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ButtonTheme(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamedAndRemoveUntil(
                                      "/menu_page", (_) => false, arguments: true);
                              log('Анонимный вход');
                            },
                            focusNode: btn_contNode,
                            child: const Text('Войти как гость'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ButtonTheme(
                          child: ElevatedButton(
                            onPressed: (_isPasswordExist == false &&
                                    _isEmailExist == false)
                                ? null
                                : () {
                                    if (passwordController.text.isEmpty ||
                                        loginController.text.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => const AlertDialog(
                                          content: Text('Заполните все поля!'),
                                        ),
                                      );
                                    } else {
                                      AuthService.signIn(
                                        email: loginController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      );
                                    }
                                  },
                            focusNode: btn_contNode,
                            child: const Text('Войти'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamedAndRemoveUntil(
                              "/login_page/registration_page", (_) => false);
                      log('Вход пользователя');
                    },
                    child: const Text('Зарегистрироваться'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkPassword(String valuePassword) {
    _password = valuePassword.trim();

    if (_password.isEmpty) {
      setState(() {
        _isPasswordExist = false;
      });
    } else if (_password.isNotEmpty) {
      setState(() {
        _isPasswordExist = true;
      });
    }
  }

  void _checkEmail(String valueEmail) {
    _email = valueEmail.trim();

    if (_email.isEmpty) {
      setState(() {
        _isEmailExist = false;
      });
    } else if (_email.isNotEmpty) {
      setState(() {
        _isEmailExist = true;
      });
    }
  }
}
