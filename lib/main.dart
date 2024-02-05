import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/intro_page.dart';

import 'home_page.dart';
import 'notadd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(360, 690),
      child: MaterialApp(
        routes: {
          "noteadd": (context) => NoteAdd(),
          "homepage": (context) => HomePage(),
        },
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
      ),
    );
  }
}
