// features/subjects/ui/page/subject_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';

class SubjectPage extends StatelessWidget {
  final String folderId;
  final String subjectId;

  const SubjectPage({
    super.key,
    required this.folderId,
    required this.subjectId,
  });

  @override
  Widget build(BuildContext context) {
    // Получаем список предметов через метод getSubjectsByFolder
    final subjects = context.watch<SubjectCubit>().state.getSubjectsByFolder(folderId);
    final index = int.parse(subjectId);
    final subjectName = index < subjects.length ? subjects[index] : 'Неизвестный предмет';

    return Scaffold(
      appBar: AppBar(title: Text(subjectName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Папка: $folderId',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Предмет: $subjectName',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: const Text('Здесь будет контент предмета...'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}