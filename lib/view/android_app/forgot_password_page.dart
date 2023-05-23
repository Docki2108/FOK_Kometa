// ignore_for_file: unused_element

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../stuffs/constant.dart';
import '../../theme/theme.dart';

class forgot_password_page extends StatelessWidget {
  const forgot_password_page({Key? key}) : super(key: key);
  static const String route = "/login_page/forgot_password_page";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          debugShowCheckedModeBanner: false,
          home: const ForgotPassword(),
        );
      }),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late FocusNode loginNode;
  late FocusNode passwordNode;
  late FocusNode btn_contNode;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final _codeController = TextEditingController();

  late String _password;
  double _strength = 0;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String _displayText = 'Введите пароль';
  bool _onEditing = true;
  String? _code;

  void _sendCode() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        'http://10.0.2.2:5000/forgot_password',
        data: {
          'email': _emailController.text,
        },
      );
      if (response.statusCode == 201) {
        log('Письмо отправлено на указаный номер телефона');
      } else {
        log('Ошибка');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _changePassword() async {
    try {
      var dio = Dio();
      var response = await dio.post(
        'http://10.0.2.2:5000/reset_password',
        data: {
          'email': _emailController.text,
          'code': _codeController.text,
          'new_password': _newPasswordController.text
        },
      );
      if (response.statusCode == 201) {
        log(response.toString());
      } else {
        log('Ошибка');
      }
    } catch (e) {
      log(e.toString());
    }
  }

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
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Восстановление доступа'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Card(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20.0),
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 60,
                                child: TextFormField(
                                  maxLength: 50,
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
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
                              const SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                ),
                                onPressed: () {
                                  _sendCode();
                                  showDialog(
                                    context: context,
                                    builder: (context) => new AlertDialog(
                                      title: const Text('Сообщение'),
                                      content: Text(
                                          textAlign: TextAlign.center,
                                          'Письмо отправлено на указаный номер телефона в профиле'),
                                    ),
                                  );
                                },
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'Отправить код на указаный номер телефона в профиле'),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                  'Введите код, который пришел вам на номер телефона, привязанный к аккаунту'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: PinCodeTextField(
                                    controller: _codeController,
                                    appContext: context,
                                    length: 6,
                                    animationType: AnimationType.scale,
                                    pinTheme: PinTheme(
                                        disabledColor: Colors.black,
                                        shape: PinCodeFieldShape.underline,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 50,
                                        fieldWidth: 40,
                                        activeFillColor: Colors.white,
                                        inactiveFillColor: Colors.black),
                                    onChanged: (value) {
                                      log(_codeController.text);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 60,
                                child: TextFormField(
                                  maxLength: 50,
                                  onChanged: (value) => _checkPassword(value),
                                  obscureText: true,
                                  controller: _newPasswordController,
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.password,
                                    ),
                                    hintText: 'Новый пароль',
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: _strength,
                                  backgroundColor: Colors.grey[300],
                                  color: _strength <= 1 / 4
                                      ? Colors.red
                                      : _strength == 2 / 4
                                          ? Colors.yellow
                                          : _strength == 3 / 4
                                              ? Colors.blue
                                              : Colors.green,
                                  minHeight: 15,
                                ),
                              ),
                              Text(
                                _displayText,
                                //style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 16,
                ),
                Container(
                  height: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ButtonTheme(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_emailController.text.isEmpty ||
                                _newPasswordController.text.isEmpty ||
                                _codeController.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (_) => const AlertDialog(
                                  title: Text(
                                    'Ошибка',
                                    style: TextStyle(),
                                  ),
                                  content: Text('Заполните все поля!'),
                                ),
                              );
                              log('Ошибка');
                            } else {
                              _changePassword();
                              // Navigator.of(context, rootNavigator: true)
                              //     .pushNamedAndRemoveUntil(
                              //         "/login_page", (t) => false);
                              log(_codeController.text);
                              log(_newPasswordController.text);
                              log(_emailController.text);
                            }
                          },
                          child: const Text('Сохранить новый пароль'),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamedAndRemoveUntil(
                                "/login_page", (t) => false);
                      },
                      child: const Text('Назад'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
        _displayText = '';
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 1 / 4;
        _displayText = 'Пароль слишком короткий! Минимум 8 символов!';
      });
    } else if (_password.length < 10) {
      setState(() {
        _strength = 2 / 4;
        _displayText = 'Пароль слишком слабый!';
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          _strength = 3 / 4;
          _displayText = 'Хороший пароль!';
        });
      } else {
        setState(() {
          _strength = 1;
          _displayText = 'Просто замечательный пароль!';
        });
      }
    }
  }
}
