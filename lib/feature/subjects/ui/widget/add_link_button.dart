import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/link/data/model/link_data_model.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';

class AddLinkButton extends StatelessWidget {
  final String folderId;
  final int subjectId;

  const AddLinkButton({
    super.key,
    required this.folderId,
    required this.subjectId,
  });

  Future<void> _showAddLinkDialog(BuildContext context) async {
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
      context.read<SubjectCubit>().addLinkToSubject(
        folderId,
        subjectId,
        result,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.add, size: 16),
      label: const Text('Добавить'),
      onPressed: () => _showAddLinkDialog(context),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
