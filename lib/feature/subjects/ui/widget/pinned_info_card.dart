import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';
import 'package:kursovaya_notebook/feature/subjects/data/model/subject_model.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widget/editable_field.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widget/links_section.dart';

class PinnedInfoCard extends StatelessWidget {
  const PinnedInfoCard({
    super.key,
    required this.folderId,
    required this.subjectId,
    required this.context,
    required this.subject,
  });

  final String folderId;
  final String subjectId;
  final BuildContext context;
  final Subject? subject;

  @override
  Widget build(BuildContext context) {
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
            EditableField(
              context: context,
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
            EditableField(
              context: context,
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
            LinksSection(links: subject?.links ?? []),
          ],
        ),
      ),
    );
  }
}
