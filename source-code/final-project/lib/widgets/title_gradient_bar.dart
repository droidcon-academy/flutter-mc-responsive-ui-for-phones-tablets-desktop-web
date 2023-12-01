import 'package:flutter/material.dart';
import 'package:responsive_split_screen/helpers/formatters.dart';
import 'package:responsive_split_screen/helpers/themes.dart';

class TitleGradientBar extends StatelessWidget {
  const TitleGradientBar({
    super.key,
    required this.title,
    required this.price,
  });

  final String title;
  final int price;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ThemeColors.gradientStart,
            ThemeColors.gradientEnd,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Text(title),
          Text(Format.toCurrency(price)),
        ],
      ),
    );
  }
}
