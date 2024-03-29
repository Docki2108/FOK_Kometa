// ignore_for_file: unused_element

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../stuffs/constant.dart';
import '../../theme/theme.dart';

class registration_page extends StatelessWidget {
  const registration_page({Key? key}) : super(key: key);
  static const String route = "/login_page/registration_page";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          debugShowCheckedModeBanner: false,
          home: const Registration(),
        );
      }),
    );
  }
}

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
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
  bool _isAgreed = false;

  late String _password;
  double _strength = 0;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String _displayText = 'Введите пароль';

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
          child: Text('Регистрация'),
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
                                alignment: Alignment.centerLeft,
                                height: 60,
                                child: TextFormField(
                                  maxLength: 50,
                                  key: _loginformKey,
                                  controller: _emailController,
                                  onEditingComplete: () =>
                                      passwordNode.nextFocus(),
                                  focusNode: loginNode,
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
                              const SizedBox(height: 20),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 60,
                                child: TextFormField(
                                  maxLength: 50,
                                  onChanged: (value) => _checkPassword(value),
                                  key: _passwordformKey,
                                  controller: _passwordController,
                                  obscureText: true,
                                  focusNode: passwordNode,
                                  onEditingComplete: () =>
                                      btn_contNode.nextFocus(),
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
                                      Icons.lock,
                                    ),
                                    hintText: 'Пароль',
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
                              const SizedBox(
                                height: 16,
                              ),
                              Stack(
                                children: [
                                  Card(
                                    elevation: 0,
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Номер телефона',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          height: 60,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: _mobileNumberController,
                                            inputFormatters: [maskTelephone],
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                              ),
                                              filled: true,
                                              hintText: "+7 (XXX) XXX-XX-XX",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                            title: Text('Номер телефона'),
                                            content: Text(
                                                'Будет использован для возможного будущего восстановления доступа'),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.info),
                                  )
                                ],
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
                              Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  title: const Text(
                                    'Персональные данные',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  subtitle: const Text(
                                      'Необязательны к заполнению. Можно добавить позже.'),
                                  children: [
                                    ListBody(
                                      children: [
                                        Card(
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Имя',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                height: 60,
                                                child: TextFormField(
                                                  maxLength: 50,
                                                  controller:
                                                      _firstNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                    counterText: '',
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(16.0),
                                                      ),
                                                    ),
                                                    filled: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListBody(
                                      children: [
                                        Card(
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Фамилия',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                height: 60,
                                                child: TextFormField(
                                                  maxLength: 50,
                                                  controller:
                                                      _secondNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                    counterText: '',
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(16.0),
                                                      ),
                                                    ),
                                                    filled: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListBody(
                                      children: [
                                        Card(
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Отчество',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                height: 60,
                                                child: TextFormField(
                                                  maxLength: 50,
                                                  controller:
                                                      _patronymicController,
                                                  decoration:
                                                      const InputDecoration(
                                                    counterText: '',
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(16.0),
                                                      ),
                                                    ),
                                                    filled: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CheckboxListTile(
                      title: const Text(
                          'Согласие на обработку персональных данных'),
                      value: _isAgreed,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAgreed = value ?? false;
                        });
                      },
                    ),
                  ),
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
                          onPressed: _strength > 1 / 2 && _isAgreed
                              ? () {
                                  if (_emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty ||
                                      _mobileNumberController.text.isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (_) => const AlertDialog(
                                        title: Text(
                                          'Ошибка',
                                          style: TextStyle(),
                                        ),
                                        content: Text(
                                            'Заполните все обязательные поля!'),
                                      ),
                                    );
                                    log('Ошибка регистрации');
                                  } else {
                                    _submitForm();
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamedAndRemoveUntil(
                                            "/login_page", (_) => false);
                                  }
                                }
                              : null,
                          focusNode: btn_contNode,
                          child: const Text('Зарегистрироваться'),
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
