import 'package:flutter/material.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widget/add_link_button.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widget/link_button.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widget/mock_links_button.dart';

class LinksSection extends StatelessWidget {
  const LinksSection({super.key, required this.links});

  final List<String> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ссылки:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            ...links.map((link) => LinkButton(title: link)),
            AddYandexLinkButton(),
            AddLinkButton(),
          ],
        ),
      ],
    );
  }
}
