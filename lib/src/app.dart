import 'package:flutter/material.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/navigation/navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Vocabulary App',
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: lightTheme,
      routerConfig: goRouter,
    );
  }
}
