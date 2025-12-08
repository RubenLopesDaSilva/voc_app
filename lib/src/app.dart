import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voc_app/src/features/repetition/presentation/word_screen.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vocabulary App',
        theme: lightTheme,
        home: const WordScreen(groupId: '6926cae85ff4c7ed2aacf390'),
      ),
    );
  }
}
