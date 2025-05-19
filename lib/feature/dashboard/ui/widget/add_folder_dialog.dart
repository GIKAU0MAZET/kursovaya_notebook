import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/dashboard/bloc/dashboard_cubit.dart';

class AddFolderDialog extends StatelessWidget {
  const AddFolderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    
    return AlertDialog(
      title: const Text('Новая папка'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Введите название папки',
          border: OutlineInputBorder(),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            final folderName = controller.text.trim();
            if (folderName.isNotEmpty) {
              context.read<DashboardCubit>().addFolder(folderName);
              Navigator.pop(context);
            }
          },
          child: const Text('Создать'),
        ),
      ],
    );
  }

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const AddFolderDialog(),
    );
  }
}