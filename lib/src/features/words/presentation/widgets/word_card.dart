import 'package:flutter/material.dart';

class WordCard extends StatefulWidget {
  const WordCard({super.key});

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  bool side = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 240,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 4.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: Text('Pomme')),
    );
  }
}
