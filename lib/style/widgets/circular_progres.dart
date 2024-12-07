import 'package:flutter/material.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';

class CircularProgres extends StatelessWidget {
  const CircularProgres({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: TypografyStyle.mainColor,
      ),
    );
  }
}
