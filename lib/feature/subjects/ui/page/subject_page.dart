import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';
import 'package:kursovaya_notebook/feature/subjects/data/model/subject_model.dart';

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
    final subjects = context.watch<SubjectCubit>().state.getSubjectsByFolder(
      folderId,
    );
    final index = int.parse(subjectId);
    final subject = index < subjects.length ? subjects[index] : null;
    final subjectName = subject?.name ?? 'Неизвестный предмет';

    return Scaffold(
      appBar: AppBar(title: Text(subjectName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPinnedInfoCard(context, subject),
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

  Widget _buildPinnedInfoCard(BuildContext context, Subject? subject) {
    final teacherController = TextEditingController(
      text: subject?.teacher ?? 'Не указан',
    );
    final assessmentController = TextEditingController(
      text: subject?.assessmentType ?? 'Не указан',
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Закреплено',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const Divider(),
            _buildEditableField(
              context,
              label: 'Преподаватель',
              controller: teacherController,
              onSaved: (value) {
                if (subject != null) {
                  context.read<SubjectCubit>().updateSubjectInfo(
                    folderId,
                    int.parse(subjectId),
                    value,
                    assessmentController.text,
                  );
                }
              },
            ),
            const SizedBox(height: 12),
            _buildEditableField(
              context,
              label: 'Вид аттестации',
              controller: assessmentController,
              onSaved: (value) {
                if (subject != null) {
                  context.read<SubjectCubit>().updateSubjectInfo(
                    folderId,
                    int.parse(subjectId),
                    teacherController.text,
                    value,
                  );
                }
              },
            ),
            const SizedBox(height: 12),
            _buildLinksSection(subject?.links ?? []),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required Function(String) onSaved,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            onSaved(controller.text);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Изменения для "$label" сохранены')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLinksSection(List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ссылки:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            ...links.map((link) => _buildLinkButton(link)),
            _buildAddLinkButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildLinkButton(String title) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.link, size: 16),
      label: Text(title),
      onPressed: () {
        // TODO: Реализовать переход по ссылке
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildAddLinkButton() {
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
