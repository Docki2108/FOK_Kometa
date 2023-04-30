import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fok_kometa/view/android_app/login_page.dart';
import 'package:fok_kometa/view/android_app/screens/screens_profile/options_page.dart';
import '../../../new_models/user.dart';
import '../../../services/auth.dart';
import 'screens_profile/feedback_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Center(
          child: Text('Профиль'),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.all(16),
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
                          padding: const EdgeInsets.all(32.0),
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
                                        color: Colors.blue, fontSize: 128)),
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
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(' '),
                      Text(
                        User.get().personalData.secondName ?? ' ',
                        style: TextStyle(fontSize: 16),
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
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(66, 16, 66, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => PersonalDataPage(),
                  //       ),
                  //     );
                  //   },
                  //   child: const Text(
                  //     'Персональные данные',
                  //   ),
                  // ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Обратная связь',
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3),
                    ),
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
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            'Внимание',
                          ),
                          content: const Text(
                            'Вы действительно хотите выйти?',
                          ),
                          actions: <Widget>[
                            OutlinedButton(
                              onPressed: () async {
                                AuthServiceMob.mobLogout();
                                Navigator.pushReplacementNamed(
                                    context, login_page.route);
                              },
                              child: const Text(
                                'ДА',
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              child: const Text(
                                'НЕТ',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
