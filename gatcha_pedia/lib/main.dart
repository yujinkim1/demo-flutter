import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gatcha_pedia/utilities/book_service.dart';
import 'package:gatcha_pedia/screens/home_screen.dart';
import 'package:gatcha_pedia/screens/bookmark_screen.dart';

late SharedPreferences sharedPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookService()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GATCHA PEDIA",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xffFF0558,
          <int, Color>{
            50: Color(0xffFFE3E7),
            100: Color(0xffFFB3C2),
            200: Color(0xffFF829D),
            300: Color(0xffFF5178),
            400: Color(0xffFF2E5E),
            500: Color(0xffFF0558),
            600: Color(0xffFF004F),
            700: Color(0xFfE60045),
            800: Color(0xffCC003C),
            900: Color(0xffA6002E),
          },
        ),
      ),
      home: const ScreenNavigatior(),
    );
  }
}

class ScreenNavigatior extends StatefulWidget {
  const ScreenNavigatior({Key? key}) : super(key: key);

  @override
  State<ScreenNavigatior> createState() => _ScreenNavigatiorState();
}

class _ScreenNavigatiorState extends State<ScreenNavigatior> {
  List screens = [
    const HomeScreen(),
    const BookmarkScreen(),
  ];

  int selectedScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffFFFFFF),
        selectedItemColor: const Color(0xffFF0558),
        unselectedItemColor: const Color(0xff333333),
        iconSize: 28.0,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        elevation: 0.0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bookmark),
            label: "북마크",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedScreenIndex,
        onTap: (index) {
          setState(() {
            selectedScreenIndex = index;
          });
        },
      ),
    );
  }
}
