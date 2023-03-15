import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

class login_page extends StatelessWidget {
  const login_page({super.key});
  static const String route = "/login_page";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: FlexThemeData.light(
      //   colors: const FlexSchemeColor(
      //     primary: Color(0xff004881),
      //     primaryContainer: Color(0xffd0e4ff),
      //     secondary: Color(0xffac3306),
      //     secondaryContainer: Color(0xffffdbcf),
      //     tertiary: Color(0xff006875),
      //     tertiaryContainer: Color(0xff95f0ff),
      //     appBarColor: Color(0xffffdbcf),
      //     error: Color(0xffb00020),
      //   ),
      //   surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      //   blendLevel: 9,
      //   subThemesData: const FlexSubThemesData(
      //     blendOnLevel: 10,
      //     blendOnColors: false,
      //   ),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   useMaterial3: true,
      //   swapLegacyOnMaterial3: true,
      //   fontFamily: GoogleFonts.notoSans().fontFamily,
      // ),
      // darkTheme: FlexThemeData.dark(
      //   colors: const FlexSchemeColor(
      //     primary: Color(0xff9fc9ff),
      //     primaryContainer: Color(0xff00325b ),
      //     secondary: Color(0xffffb59d),
      //     secondaryContainer: Color(0xff872100),
      //     tertiary: Color(0xff86d2e1),
      //     tertiaryContainer: Color(0xff004e59),
      //     appBarColor: Color(0xff872100),
      //     error: Color(0xffcf6679),
      //   ),
      //   surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      //   blendLevel: 15,
      //   subThemesData: const FlexSubThemesData(
      //     blendOnLevel: 20,
      //   ),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   useMaterial3: true,
      //   swapLegacyOnMaterial3: true,
      //   fontFamily: GoogleFonts.notoSans().fontFamily,
      // ),
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blueGrey,
        useMaterial3: true,
      ),
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

  final _loginformKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();
  final _fokformKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 166, 189, 208),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage("lib/theme/images/noisable-gradient-1-small.jpg"),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.start_outlined,
                          size: 100,
                        ),
                        const SizedBox(height: 50),
                        Text(
                          key: _fokformKey,
                          'ФОК Комета',
                          style: const TextStyle(
                            fontSize: 36,
                          ),
                        ),
                        const SizedBox(height: 70),
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
                              //border: InputBorder.none,
                              focusColor: Colors.brown,
                              prefixIcon: Icon(
                                Icons.account_circle_outlined,
                              ),
                              hintText: 'Логин',
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
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ButtonTheme(
                          shape: CircleBorder(),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed("/menu_page");
                            },
                            focusNode: btn_contNode,
                            style: ButtonStyle(),
                            child: Text('Войти'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[700],
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
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    'Впервые тут?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/login_page/registration_page");
                        },
                        child: const Text('Зарегистрироваться'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
