import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

class login_page extends StatelessWidget {
  /// Constructs a [login_page]
  const login_page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff004881),
          primaryContainer: Color(0xffd0e4ff),
          secondary: Color(0xffac3306),
          secondaryContainer: Color(0xffffdbcf),
          tertiary: Color(0xff006875),
          tertiaryContainer: Color(0xff95f0ff),
          appBarColor: Color(0xffffdbcf),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xff9fc9ff),
          primaryContainer: Color(0xff00325b),
          secondary: Color(0xffffb59d),
          secondaryContainer: Color(0xff872100),
          tertiary: Color(0xff86d2e1),
          tertiaryContainer: Color(0xff004e59),
          appBarColor: Color(0xff872100),
          error: Color(0xffcf6679),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   colorSchemeSeed: Colors.blue,
      //   useMaterial3: true,
      // ),
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
                          fontSize: 36,
                        ),
                      ),
                      const SizedBox(height: 70),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            // border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.account_circle_outlined,
                            ),
                            hintText: 'Логин',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            //border: InputBorder.none,
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
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ButtonTheme(
                        shape: const CircleBorder(),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed("/menu_page");
                          },
                          focusNode: btn_contNode,
                          style: const ButtonStyle(),
                          child: const Text('Войти'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           'Или войдите с',
                //           style: TextStyle(
                //             color: Colors.grey[700],
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
                    GestureDetector(
                      onTap: () {},
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
