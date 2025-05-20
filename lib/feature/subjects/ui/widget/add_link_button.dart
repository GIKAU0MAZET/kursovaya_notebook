import 'package:flutter/material.dart';

class AddLinkButton extends StatelessWidget {
  const AddLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.add, size: 16),
      label: const Text('Добавить'),
      onPressed: () {
        // TODO: Реализовать добавление ссылки
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
