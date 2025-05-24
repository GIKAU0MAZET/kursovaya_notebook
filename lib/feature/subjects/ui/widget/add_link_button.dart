import 'package:flutter/material.dart';
import 'package:kursovaya_notebook/feature/link/data/model/link_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AddLinkButton extends StatefulWidget {
  const AddLinkButton({super.key});

  @override
  State<AddLinkButton> createState() => _AddLinkButtonState();
}

class _AddLinkButtonState extends State<AddLinkButton> {
  final List<LinkData> _links = [];

  Future<void> _addLink(BuildContext context) async {
    final urlController = TextEditingController();
    final nameController = TextEditingController();

    final result = await showDialog<LinkData>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Добавить ссылку'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: 'Ссылка (https://...)',
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Название ссылки',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () {
                  final url = urlController.text.trim();
                  final name = nameController.text.trim();
                  if (Uri.tryParse(url)?.hasAbsolutePath == true) {
                    Navigator.pop(
                      context,
                      LinkData(name: name.isNotEmpty ? name : url, url: url),
                    );
                  }
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
    );

    if (result != null) {
      setState(() {
        _links.add(result);
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось открыть ссылку')),
      );
    }
  }

  void _removeLink(int index) {
    setState(() {
      _links.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ссылки (слева), они будут автоматически переноситься
        if (_links.isEmpty)
          const Text(
            'Нет добавленных ссылок',
            style: TextStyle(color: Colors.grey),
          )
        else
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children:
                _links.map((link) {
                  final index = _links.indexOf(link);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _launchUrl(link.url),
                        icon: const Icon(Icons.link, size: 16),
                        label: Text(link.name),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed: () => _removeLink(index),
                      ),
                    ],
                  );
                }).toList(),
          ),

        // Кнопка "Добавить" (справа)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: OutlinedButton.icon(
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Добавить'),
            onPressed: () => _addLink(context),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
