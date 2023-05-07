// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/view/android_app/login_page.dart';
import 'package:fok_kometa/view/android_app/screens/screens_profile/options_page.dart';
import '../../../new_models/user.dart';
import '../../../services/auth.dart';
import '../../../stuffs/constant.dart';
import 'screens_profile/feedback_page.dart';
import 'screens_profile/weight_calendar.dart';

class profile_page extends StatelessWidget {
  const profile_page({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.parentNavigatorContext}) : super(key: key);
  final BuildContext? parentNavigatorContext;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late FocusNode _emailNode;
  late FocusNode _firstNameNode;
  late FocusNode _secondNameNode;
  late FocusNode _patronymicNameNode;
  late FocusNode _mobileNumberNameNode;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _secondNameController = TextEditingController();
  TextEditingController _patronymicController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

  @override
  void initState() {
    _emailNode = FocusNode();
    _firstNameNode = FocusNode();
    _secondNameNode = FocusNode();
    _patronymicNameNode = FocusNode();
    _mobileNumberNameNode = FocusNode();

    _emailController.text = User.get().email;
    _firstNameController.text = User.get().personalData.firstName.toString();
    _secondNameController.text = User.get().personalData.secondName.toString();
    _patronymicController.text = User.get().personalData.patronymic.toString();
    _mobileNumberController.text =
        User.get().personalData.mobileNumber.toString();

    super.initState();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _firstNameNode.dispose();
    _secondNameNode.dispose();
    _patronymicNameNode.dispose();
    _mobileNumberNameNode.dispose();

    _emailController.dispose();
    _firstNameController.dispose();
    _secondNameController.dispose();
    _patronymicController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _updateUser() async {
    try {
      var dio = Dio();
      var response = await dio.post(
        'http://10.0.2.2:5000/update_user',
        data: {
          'email': _emailController.text,
          'second_name': User.get().personalData.secondName
        },
      );
      if (response.statusCode == 201) {
        log('Изменение прошло успешно!');
      } else {
        log('Ошибка!');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Center(
          child: Text('Профиль'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              elevation: 6,
              child: Column(
                children: [
                  Stack(
                    children: [
                      if (User.get().personalData.secondName == null &&
                          User.get().personalData.firstName == null)
                        const Center(
                          child: Icon(
                            Icons.account_box,
                            size: 280,
                          ),
                        ),
                      if (User.get().personalData.secondName != null &&
                          User.get().personalData.firstName != null)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            elevation: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  User.get()
                                          .personalData
                                          .firstName
                                          ?.substring(0, 1) ??
                                      ' ',
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 128),
                                ),
                                Text(
                                  User.get()
                                          .personalData
                                          .secondName
                                          ?.substring(0, 1) ??
                                      ' ',
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 128),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        User.get().personalData.firstName ?? ' ',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Text(' '),
                      Text(
                        User.get().personalData.secondName ?? ' ',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        User.get().email,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Card(
                      elevation: 0,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: const Text('Полные персональные данные'),
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  const Text('Почта: '),
                                  Text(User.get().email),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  const Text('Имя: '),
                                  Text(
                                      User.get().personalData.firstName ?? ' '),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  const Text('Фамилия: '),
                                  Text(User.get().personalData.secondName ??
                                      ' '),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  const Text('Отчество: '),
                                  Text(User.get().personalData.patronymic ??
                                      '...'),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  const Text('Номер телефона: '),
                                  Text(User.get().personalData.mobileNumber ??
                                      ' '),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Ваши данные',
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Card(
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Почта',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 60,
                                                        child: TextFormField(
                                                          controller:
                                                              _emailController,
                                                          //focusNode: passwordNode,
                                                          // onEditingComplete: () =>
                                                          //    btn_contNode.nextFocus(),
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    16.0),
                                                              ),
                                                            ),
                                                            filled: true,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Card(
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Имя',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 60,
                                                        child: TextFormField(
                                                          controller:
                                                              _firstNameController,
                                                          //focusNode: passwordNode,
                                                          // onEditingComplete: () =>
                                                          //    btn_contNode.nextFocus(),
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    16.0),
                                                              ),
                                                            ),
                                                            filled: true,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Card(
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Фамилия',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 60,
                                                        child: TextFormField(
                                                          controller:
                                                              _secondNameController,
                                                          //focusNode: passwordNode,
                                                          // onEditingComplete: () =>
                                                          //    btn_contNode.nextFocus(),
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    16.0),
                                                              ),
                                                            ),
                                                            filled: true,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Card(
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Отчество',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 60,
                                                        child: TextFormField(
                                                          controller:
                                                              _patronymicController,
                                                          //focusNode: passwordNode,
                                                          // onEditingComplete: () =>
                                                          //    btn_contNode.nextFocus(),
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    16.0),
                                                              ),
                                                            ),
                                                            filled: true,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Card(
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Телефон',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 60,
                                                        child: TextFormField(
                                                          inputFormatters: [
                                                            maskTelephone
                                                          ],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              _mobileNumberController,
                                                          //focusNode: passwordNode,
                                                          // onEditingComplete: () =>
                                                          //    btn_contNode.nextFocus(),
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    16.0),
                                                              ),
                                                            ),
                                                            filled: true,
                                                            hintText:
                                                                "+7 (XXX) XXX-XX-XX",
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                  },
                                                  child: const Text(
                                                    'Закрыть',
                                                  ),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                    'Изменить',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Text('Изменить'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(66, 16, 66, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      // style: ButtonStyle(
                      //   elevation: MaterialStateProperty.all(3),
                      // ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeightCalendar(
                              User.get().email,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'График массы тела',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      // style: ButtonStyle(
                      //   elevation: MaterialStateProperty.all(3),
                      // ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FeedbackPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Обратная связь',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      // style: ButtonStyle(
                      //   elevation: MaterialStateProperty.all(3),
                      // ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OptionsPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Настройки',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      // style: ButtonStyle(
                      //   elevation: MaterialStateProperty.all(3),
                      // ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              'Внимание',
                            ),
                            content: const Text(
                              'Вы действительно хотите выйти?',
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: <Widget>[
                              OutlinedButton(
                                style: ButtonStyle(),
                                onPressed: () async {
                                  AuthServiceMob.mobLogout();
                                  Navigator.pushReplacementNamed(
                                      context, login_page.route);
                                },
                                child: const Text(
                                  'ДА',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: const Text(
                                  'НЕТ',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        'Выйти',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
