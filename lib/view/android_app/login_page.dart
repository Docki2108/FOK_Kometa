import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fok_kometa/services/auth_repository.dart';
import 'package:fok_kometa/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../stuffs/widgets.dart';

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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _loginformKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();
  final _fokformKey = GlobalKey<FormState>();

  late String _email;
  late String _password;
  bool _isAllExist = false;
  bool _isPasswordExist = false;
  bool _isEmailExist = false;
  bool _isLoading = false;
  bool light0 = true;

  @override
  void initState() {
    loginNode = FocusNode();
    passwordNode = FocusNode();
    btn_contNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    loginNode.dispose();
    passwordNode.dispose();
    btn_contNode.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                logosvg,
                Container(
                  margin: const EdgeInsets.all(40.0),
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: TextFormField(
                          onChanged: (value1) => {
                            _checkEmail(value1),
                            value1 = _passwordController.text.trim()
                          },
                          key: _loginformKey,
                          controller: _emailController,
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
                          controller: _passwordController,
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
                Container(
                  margin: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamedAndRemoveUntil(
                                    "/login_page/registration_page",
                                    (_) => false);
                            log('Вход пользователя');
                          },
                          child: const Text('Зарегистрироваться'),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ButtonTheme(
                            child: ElevatedButton(
                              onPressed: (_isPasswordExist == false &&
                                      _isEmailExist == false)
                                  ? null
                                  : () {
                                      if (_passwordController.text.isEmpty ||
                                          _emailController.text.isEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => const AlertDialog(
                                            content:
                                                Text('Заполните все поля!'),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        AuthRepository.mobLogin(
                                                _emailController.text.trim(),
                                                _passwordController.text.trim())
                                            .then((value) {
                                          setState(() {
                                            _isLoading = false;

                                            if (value == null) {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) =>
                                                    const AlertDialog(
                                                  title: Text('Ошибка входа!'),
                                                  content: Text(
                                                      "Проверьте введенные данные"),
                                                ),
                                              );
                                            } else {
                                              log(value.toString());
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushNamedAndRemoveUntil(
                                                      "/menu_page",
                                                      (_) => false,
                                                      arguments: true);
                                            }
                                          });
                                        });
                                      }
                                    },
                              focusNode: btn_contNode,
                              child: const Text('Войти'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '  или  ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ButtonTheme(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamedAndRemoveUntil("/menu_page", (_) => false,
                                arguments: true);
                        log('Анонимный вход');
                      },
                      focusNode: btn_contNode,
                      child: const Text('Войти как гость'),
                    ),
                  ),
                ),
              ],
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
