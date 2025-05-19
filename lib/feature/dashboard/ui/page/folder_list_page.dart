import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kursovaya_notebook/feature/dashboard/bloc/dashboard_cubit.dart';
import 'package:kursovaya_notebook/feature/dashboard/ui/widget/add_folder_dialog.dart';

class FoldersListScreen extends StatelessWidget {
  const FoldersListScreen({super.key});

  static const path = '/folders';

  @override
  Widget build(BuildContext context) {
    final folders = context.watch<DashboardCubit>().state.folders;

    return Scaffold(
      appBar: AppBar(title: const Text('Мои папки')),
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder:
            (context, index) => ListTile(
              title: Text(folders[index]),
              onTap: () => context.go('/folders/${index + 1}'),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showDialog(
              context: context,
              builder: (context) => AddFolderDialog(),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
