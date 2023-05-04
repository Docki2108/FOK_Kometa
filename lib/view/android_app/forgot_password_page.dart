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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _roleController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _patronymicController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  final _loginformKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();

  late String _password;
  double _strength = 0;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String _displayText = 'Введите пароль';
  bool _onEditing = true;
  String? _code;

  void _submitForm() async {
    try {
      var dio = Dio();
      var response = await dio.post(
        'http://10.0.2.2:5000/register',
        data: {
          'email': _emailController.text,
          'password': _passwordController.text,
          'role': "Client",
          'second_name': _secondNameController.text,
          'first_name': _firstNameController.text,
          'patronymic': _patronymicController.text,
          'mobile_number': _mobileNumberController.text
        },
      );
      if (response.statusCode == 201) {
        log('Пользователь успешно зарегистрирован!');
      } else {
        log('Ошибка в регистрации!');
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
    _passwordController.dispose();
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
                                  controller: _emailController,
                                  decoration: const InputDecoration(
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
                              SizedBox(
                                height: 16,
                              ),
                              OutlinedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                ),
                                onPressed: () {},
                                child: Text('Отправить код на почту'),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                  'Введите код, который пришел вам на номер телефона, привязанный к аккаунту'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: PinCodeTextField(
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
                                      print(value);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 60,
                                child: TextFormField(
                                  obscureText: true,
                                  // controller: _emailController,
                                  decoration: const InputDecoration(
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
                          onPressed: () {},
                          // _strength < 1 / 2
                          //     ? null
                          //     : () {
                          //         if (_emailController.text.isEmpty ||
                          //             _passwordController.text.isEmpty) {
                          //           showDialog(
                          //             context: context,
                          //             builder: (_) => const AlertDialog(
                          //               title: Text(
                          //                 'Ошибка',
                          //                 style: TextStyle(),
                          //               ),
                          //               content: Text('Заполните все поля!'),
                          //             ),
                          //           );
                          //           log('Ошибка регистрации');
                          //         } else {
                          //           _submitForm();
                          //           Navigator.of(context, rootNavigator: true)
                          //               .pushNamedAndRemoveUntil(
                          //                   "/login_page", (_) => false);
                          //         }
                          //       },

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
        _displayText = 'Введите пароль';
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
