import 'package:flutter/material.dart';
import 'package:fok_kometa/view/android_app/login_page.dart';
import 'package:fok_kometa/view/android_app/screens/screens_profile/options_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens_main/bioritm_page.dart';
import 'screens_profile/calculators_page.dart';
import 'screens_main/diets_page.dart';
import 'screens_profile/feedback_page.dart';
import 'screens_profile/personal_data_page.dart';
import 'screens_main/sleep_page.dart';

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
  late User supaUser;
  Map? thisUser;
  @override
  initState() {
    // supaUser = Supabase.instance.client.auth.currentUser!;

    // Supabase.instance.client
    //     .from("personal_data")
    //     .select()
    //     .eq("id_personal_data", supaUser.id)
    //     .then((value) {
    //   setState(() {
    //     thisUser = value[0];
    //   });
    // });

    super.initState();
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
                  const Icon(
                    Icons.account_box,
                    size: 280,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        thisUser?['first_name'] ?? ' ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(' '),
                      Text(
                        thisUser?['second_name'] ?? ' ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                          'email' //Supabase.instance.client.auth.currentUser!.email!,
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
                                // Supabase.instance.client.auth.signOut();
                                // if (Supabase.instance.client.auth.currentUser ==
                                //     null) {
                                Navigator.pushReplacementNamed(
                                    context, login_page.route);
                                // }
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
