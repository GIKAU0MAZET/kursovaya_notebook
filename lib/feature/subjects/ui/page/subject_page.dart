import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/note/bloc/note_bloc.dart';
import 'package:kursovaya_notebook/feature/note/bloc/note_state.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widget/editable_note_field.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widget/pinned_info_card.dart';

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
    final TextEditingController noteController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(subjectName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PinnedInfoCard(
              folderId: folderId,
              subjectId: subjectId,
              context: context,
              subject: subject,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BlocBuilder<NoteCubit, NoteState>(
                        builder: (context, state) {
                          final notes = state.getNotesBySubject(subjectId);

                          if (notes.isEmpty) {
                            return const Text('Нет заметок по этому предмету.');
                          }

                          return ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              final note = notes[index];
                              return EditableNoteField(note: note);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: noteController,
                            maxLines: null,
                            minLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Введите заметку...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send, size: 28),
                          onPressed: () {
                            final content = noteController.text.trim();
                            if (content.isNotEmpty) {
                              context.read<NoteCubit>().addNote(
                                subjectId,
                                content,
                              );
                              noteController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
