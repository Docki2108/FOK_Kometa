import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fok_kometa/services/auth_repository.dart';
import '../../services/auth.dart';
import '../../stuffs/widgets.dart';

class WinLoginPage extends StatefulWidget {
  @override
  _WinLoginPageState createState() => _WinLoginPageState();
}

class _WinLoginPageState extends State<WinLoginPage> {
  static const String route = "/win_login_page";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final dio = Dio();
  final _authService = AuthService();
  String _errorMessage = '';
  String? _accessToken;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: FluentTheme(
        data: ThemeData(
          accentColor: Colors.blue,
        ),
        child: ScaffoldPage(
          resizeToAvoidBottomInset: false,
          // header: Text('asdfasd'),
          content: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.teal],
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        logosvg,
                        Card(
                          child: Container(
                            padding: const EdgeInsets.all(32.0),
                            width: 400.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 20.0),
                                const Text(
                                  'Вход',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 40.0),
                                TextBox(
                                  maxLength: 30,
                                  controller: _emailController,
                                  placeholder: 'Почта',
                                ),
                                const SizedBox(height: 20.0),
                                TextBox(
                                  controller: _passwordController,
                                  placeholder: 'Пароль',
                                  obscureText: true,
                                ),
                                const SizedBox(height: 40.0),
                                Button(
                                  onPressed: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    AuthRepository.login(
                                            _emailController.text.trim(),
                                            _passwordController.text.trim())
                                        .then((value) {
                                      setState(() {
                                        _isLoading = false;
                                        if (value == null) {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => ContentDialog(
                                                    content: Text("Ошибка"),
                                                  ));
                                        } else {
                                          log(value.toString());
                                        }
                                      });
                                    });
                                  },
                                  child: const Text('Войти'),
                                ),
                                // Button(
                                //   child: Text('map'),
                                //   onPressed: () async {
                                //     if (await canLaunch(FOK_KOMETA_MAP_URL)) {
                                //       await launch(FOK_KOMETA_MAP_URL);
                                //     } else {
                                //       throw 'Ошибка перехода на URL: $FOK_KOMETA_MAP_URL';
                                //     }
                                //   },
                                // )
                              ],
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
        ),
      ),
    );
  }
}
