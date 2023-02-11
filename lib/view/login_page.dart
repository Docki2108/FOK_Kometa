import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class LoginPage1 extends StatelessWidget {
  const LoginPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //themeMode: ThemeMode.system,
      theme: FlexThemeData.light(
        // scheme: FlexScheme.shark,
        background: Colors.amberAccent,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.shark),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
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
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(5.0),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black),
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.start_outlined,
                        size: 100,
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'ФОК Комета',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                        child: TextField(
                          controller: loginController,
                          onEditingComplete: () => passwordNode.nextFocus(),
                          focusNode: loginNode,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Логин',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: TextField(
                          controller: passwordController,
                          onEditingComplete: () => btn_contNode.nextFocus(),
                          focusNode: passwordNode,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Пароль',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 100.0,
                  shape: const CircleBorder(),
                  child: OutlinedButton(
                    focusNode: btn_contNode,
                    onPressed: () {},
                    style: const ButtonStyle(),
                    child: const Text('Войти'),
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Или войдите с',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(width: 25),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Впервые тут?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Зарегистрироваться'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       TextButton(
//         child: const Text('Забыл пароль'),
//         onPressed: () {},
//       ),
//     ],
//   ),
// ),