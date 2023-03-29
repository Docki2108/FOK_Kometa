import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../service/auth.service.dart';
import '../theme/theme.dart';

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
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _loginformKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();
  final _fokformKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginNode = FocusNode();
    passwordNode = FocusNode();
    btn_contNode = FocusNode();
    super.initState();
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacementNamed('/menu_page');
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
      appBar: AppBar(
        title: const Center(
          child: Text('Регистрация'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        height: double.infinity,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(
        //           "lib/theme/images/background/noisable-gradient-1-small.jpg"),
        //       fit: BoxFit.fill),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 16, 0, 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
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
                              key: _loginformKey,
                              controller: loginController,
                              onEditingComplete: () => passwordNode.nextFocus(),
                              focusNode: loginNode,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                filled: true,
                                fillColor: Colors.white,
                                focusColor: Colors.brown,
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
                              key: _passwordformKey,
                              controller: passwordController,
                              obscureText: true,
                              focusNode: passwordNode,
                              onEditingComplete: () => btn_contNode.nextFocus(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                ),
                                hintText: 'Пароль',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ButtonTheme(
                    shape: CircleBorder(),
                    child: ElevatedButton(
                      onPressed: () {
                        AuthService.signUp(
                          email: loginController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        Navigator.of(context, rootNavigator: true)
                            .pushNamedAndRemoveUntil(
                                "/menu_page", (_) => false);
                      },
                      focusNode: btn_contNode,
                      child: const Text('Зарегистрироваться'),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil("/login_page", (t) => false);
                  },
                  child: const Text('Назад'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
