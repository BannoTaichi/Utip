import 'package:flutter/material.dart';

class TotalPerPerson extends StatelessWidget {
  const TotalPerPerson({
    super.key,
    required this.theme,
    required this.style,
    required this.total,
  });

  final ThemeData theme;
  final TextStyle style;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            // Theme基準で色使用
            color: theme.colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Text("Total per person",
                //Theme基準から文字サイズ使用
                style: style),
            // toStringAsFixed : 有効数字調整
            Text(total.toStringAsFixed(2),
                style: style.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontSize: theme.textTheme.displaySmall?.fontSize))
          ],
        ),
      ),
    );
  }
}
