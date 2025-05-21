import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kursovaya_notebook/feature/dashboard/bloc/dashboard_cubit.dart';
import 'package:kursovaya_notebook/feature/folders/ui/widget/add_folder_dialog.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widget/add_subject_dialog.dart';

class FoldersListScreen extends StatelessWidget {
  const FoldersListScreen({super.key});

  static const path = '/folders';

  @override
  Widget build(BuildContext context) {
    final folders = context.watch<DashboardCubit>().state.folders;
    final subjectsCubit = context.watch<SubjectCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Мои папки')),
      body:
          folders.isEmpty
              ? const Center(
                child: Text(
                  'Нет папок',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  final folder = folders[index];
                  final subjects =
                      subjectsCubit.state.foldersSubjects[folder.id] ?? [];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                        title: Text(
                          folder.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: Column(
                              children: [
                                if (subjects.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      'Создай предмет',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                else
                                  ...subjects.map(
                                    (subject) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: InkWell(
                                        onTap:
                                            () => context.push(
                                              '${FoldersListScreen.path}/${folder.id}/subjects/${subjects.indexOf(subject)}',
                                            ),
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(
                                                0.3,
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            subject.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                _AddSubjectButton(folderId: folder.id),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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

class _AddSubjectButton extends StatelessWidget {
  final String folderId;

  const _AddSubjectButton({required this.folderId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => showDialog(
            context: context,
            builder: (_) => AddSubjectDialog(folderId: folderId),
          ),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.add, size: 20),
      ),
    );
  }
}
