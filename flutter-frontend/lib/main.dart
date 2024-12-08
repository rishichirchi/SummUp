import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/constants/theme.dart';
import 'package:news_pulse/view/home/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SummUp',
      debugShowCheckedModeBanner: false,
      theme:theme,
      home: const HomeScreen(),
    );
  }
}
