import 'package:flutter/material.dart';

class BookInfoRow extends StatelessWidget {
  const BookInfoRow({super.key, required this.icon, required this.text});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(icon),
        Text(text, style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
