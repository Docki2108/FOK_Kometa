import 'package:flutter/material.dart';
import 'package:fok_kometa/view/screens/screens_profile/options_page.dart';

import 'screens_profile/feedback_page.dart';
import 'screens_profile/personal_data_page.dart';

class profile_page extends StatelessWidget {
  const profile_page({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProfilePage(),
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
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(
        //           "lib/theme/images/background/layered-waves-haikei.png"),
        //       fit: BoxFit.fill),
        // ),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  const Icon(
                    Icons.account_box,
                    size: 280,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Имя',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(' '),
                      Text(
                        'Фамилия',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('почта@mail.ru'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(66, 32, 66, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalDataPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Персональные данные',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Диеты',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Калькуляторы',
                    ),
                  ),
                  ElevatedButton(
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
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamedAndRemoveUntil(
                                        "/login_page", (t) => false);
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
                    child: Text(
                      'Выйти',
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(25),
                  //       color: Colors.white,
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           blurRadius: 10,
                  //           offset: Offset(0, 0),
                  //           color: Colors.grey,
                  //         ),
                  //         BoxShadow(
                  //           blurRadius: 10,
                  //           offset: Offset(-5, -5),
                  //           color: Colors.white,
                  //         )
                  //       ]),
                  //   child: const SizedBox(
                  //     height: 50,
                  //     width: 100,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
