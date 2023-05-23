import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth.dart';
import '../../services/auth_repository.dart';
import '../../stuffs/widgets.dart';
import '../../theme/theme.dart';

class win_login_page extends StatelessWidget {
  const win_login_page({super.key});
  static const String route = "/win_login_page";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: WinLoginPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class WinLoginPage extends StatefulWidget {
  @override
  _WinLoginPageState createState() => _WinLoginPageState();
}

class _WinLoginPageState extends State<WinLoginPage> {
  static const String route = "/win_login_page";

  late FocusNode emailNode;
  late FocusNode passwordNode;
  late FocusNode btnNode;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final dio = Dio();
  final _authService = AuthServiceWin();
  String _errorMessage = '';
  String? _accessToken;

  @override
  void initState() {
    emailNode = FocusNode();
    passwordNode = FocusNode();
    btnNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailNode.dispose();
    passwordNode.dispose();
    btnNode.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Color.fromARGB(255, 216, 228, 255)],
          ),
        ),
        child: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                    width: constraints.maxWidth * 0.75,
                    height: constraints.maxHeight * 0.75,
                    child: logosvg,
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          const Text(
                            'Авторизация',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 300.0,
                              maxHeight: 50.0,
                            ),
                            child: TextFormField(
                              maxLength: 50,
                              focusNode: emailNode,
                              onEditingComplete: () => passwordNode.nextFocus(),
                              controller: _emailController,
                              decoration: const InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                hintText: 'Почта',
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 300.0,
                              maxHeight: 50.0,
                            ),
                            child: TextFormField(
                              maxLength: 50,
                              controller: _passwordController,
                              focusNode: passwordNode,
                              onEditingComplete: () => btnNode.nextFocus(),
                              obscureText: true,
                              decoration: const InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                hintText: 'Пароль',
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          OutlinedButton(
                            focusNode: btnNode,
                            onPressed: () {
                              if (_passwordController.text.isEmpty ||
                                  _emailController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                    content: Text('Заполните все поля!'),
                                  ),
                                );
                              } else {
                                AuthRepository.winLogin(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim())
                                    .then((value) {
                                  setState(() {
                                    if (value == null) {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => const AlertDialog(
                                          title: Text('Ошибка входа!'),
                                          content: Text(
                                              "Проверьте введенные данные"),
                                        ),
                                      );
                                    } else {
                                      log(value.toString());
                                      Navigator.of(context, rootNavigator: true)
                                          .pushNamedAndRemoveUntil(
                                              "/win_menu_page", (_) => false,
                                              arguments: true);
                                    }
                                  });
                                });
                              }
                            },
                            child: Text('Войти'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
