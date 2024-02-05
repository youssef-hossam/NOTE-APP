import 'package:flutter/material.dart';

import 'home_page.dart';
import 'notadd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "noteadd": (context) => NoteAdd(),
      },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
