import 'package:fluent_ui/fluent_ui.dart';

class WinLoginPage extends StatefulWidget {
  @override
  _WinLoginPageState createState() => _WinLoginPageState();
}

class _WinLoginPageState extends State<WinLoginPage> {
  static const String route = "/win_login_page";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: FluentTheme(
        data: ThemeData(
          accentColor: Colors.purple,
        ),
        child: ScaffoldPage(
          content: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Card(
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
                        onPressed: () {},
                        child: const Text('Войти'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
