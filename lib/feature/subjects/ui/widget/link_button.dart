import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.link, size: 16),
      label: Text(title),
      onPressed: () {
        // TODO: Реализовать переход по ссылке
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
