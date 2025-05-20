import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kursovaya_notebook/feature/dashboard/ui/page/folder_list_page.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widgets/add_subject_dialog.dart';

class FolderPage extends StatelessWidget {
  final String folderId;

  const FolderPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    final subjects =
        context.watch<SubjectCubit>().state.foldersSubjects[folderId] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('Папка $folderId')),
      body:
          subjects.isEmpty
              ? const Center(child: Text('Пока нет предметов'))
              : ListView.separated(
                padding: const EdgeInsets.all(16),
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemCount: subjects.length,
                itemBuilder:
                    (context, index) => Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text(subjects[index].name),
                        onTap:
                            () => context.push(
                              '${FoldersListScreen.path}/$folderId/subjects/$index',
                            ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showDialog(
              context: context,
              builder: (_) => AddSubjectDialog(folderId: folderId),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
