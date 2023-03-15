import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class four_page extends StatelessWidget {
  const four_page({
    Key? key,
  }) : super(key: key);
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
      home: const FourPage(),
    );
  }
}

class FourPage extends StatefulWidget {
  const FourPage({Key? key, this.parentNavigatorContext}) : super(key: key);
  final BuildContext? parentNavigatorContext;

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade200,
        title: const Center(
          child: Text('Профиль'),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(color: Colors.blueGrey.shade100),
              child: Column(
                children: [
                  Icon(
                    Icons.account_box,
                    size: 280,
                    color: Colors.blueGrey.shade500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Имя'),
                      Text(' '),
                      Text('Фамилия'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('почта@mail.ru'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(color: Colors.blueGrey.shade500),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamedAndRemoveUntil("/login_page", (t) => false);
                    },
                    child: Text('Назад'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamedAndRemoveUntil("/login_page", (t) => false);
                    },
                    child: Text('Выйти'),
                  ),
                ],
              ),
            ),
          ),

          // InkWell(
          //   onTap: () {},
          //   child: Ink(
          //     height: 70,
          //     color: Colors.blue.shade400,
          //     child: Row(
          //       children: const [Icon(Icons.settings), Text('Настройки')],
          //     ),
          //   ),
          // ),
          // const Divider(
          //   thickness: 1,
          //   height: 1,
          //   color: Colors.black,
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context, rootNavigator: true)
          //         .pushNamedAndRemoveUntil("/login_page", (t) => false);
          //   },
          //   child: Ink(
          //     height: 70,
          //     color: Colors.blue.shade400,
          //     child: Row(
          //       children: const [
          //         Icon(Icons.exit_to_app_sharp),
          //         Text('Выход')
          //       ],
          //     ),
          //   ),
          // ),
          // const Divider(
          //   thickness: 1,
          //   height: 1,
          //   color: Colors.black,
          // ),
          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: Icon(Icons.settings),
          //   label: Text('Настройки'),
          //   style: ButtonStyle(),
          // ),
          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: Icon(Icons.three_p_outlined),
          //   label: Text('хихихи'),
          //   style: ButtonStyle(),
          // ),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     Navigator.of(context, rootNavigator: true)
          //         .pushNamed("/login_page");
          //   },
          //   icon: Icon(Icons.exit_to_app_sharp),
          //   label: Text('Выход'),
          //   style: ButtonStyle(),
          // ),
        ],
      ),
    );
  }
}
