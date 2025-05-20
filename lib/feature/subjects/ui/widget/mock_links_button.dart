import 'package:flutter/material.dart';

class AddYandexLinkButton extends StatelessWidget {
  const AddYandexLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.cloud, size: 16), // Можно выбрать иконку облака
      label: const Text('Яндекс.Диск'),
      onPressed: () {
        // Реализуйте здесь переход к Яндекс.Диску или добавление ссылки
        print('Добавить ссылку на Яндекс.Диск');
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
