import 'package:flutter/material.dart';

class FancyHeading extends StatelessWidget {
  const FancyHeading({super.key, required this.headingText});

  final String headingText;

  @override
  Widget build(BuildContext context) {
    return Text(headingText,
        style: TextStyle(
            color: Colors.red[900],
            fontSize: 24.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                  blurRadius: 8.0,
                  color: Colors.grey,
                  offset: Offset.fromDirection(1.0, 5.0))
            ]));
  }
}
