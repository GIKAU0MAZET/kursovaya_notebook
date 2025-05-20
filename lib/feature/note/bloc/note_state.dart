import 'package:kursovaya_notebook/feature/note/data/model/note_model.dart';

class NoteState {
  final List<Note> notes;

  NoteState({required this.notes});

  List<Note> getNotesBySubject(String subjectId) {
    return notes.where((n) => n.subjectId == subjectId).toList();
  }

  NoteState copyWith({List<Note>? notes}) {
    return NoteState(notes: notes ?? this.notes);
  }
}
