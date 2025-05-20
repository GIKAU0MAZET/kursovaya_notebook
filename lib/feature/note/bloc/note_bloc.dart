import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/note/bloc/note_state.dart';
import 'package:kursovaya_notebook/feature/note/data/model/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteState(notes: []));

  void addNote(String subjectId, String content) {
    final newNote = Note(
      id: const Uuid().v4(),
      subjectId: subjectId,
      content: content,
      createdAt: DateTime.now(),
    );
    emit(state.copyWith(notes: [...state.notes, newNote]));
  }

  void deleteNote(String noteId) {
    final updatedNotes =
        state.notes.where((note) => note.id != noteId).toList();
    emit(state.copyWith(notes: updatedNotes));
  }

  void updateNote(String noteId, String newContent) {
    final updatedNotes =
        state.notes.map((note) {
          if (note.id == noteId) {
            return Note(
              id: note.id,
              subjectId: note.subjectId,
              content: newContent,
              createdAt: note.createdAt, // оставим дату создания
            );
          }
          return note;
        }).toList();

    emit(state.copyWith(notes: updatedNotes));
  }

  static BlocProvider<NoteCubit> provider() {
    return BlocProvider(create: (context) => NoteCubit());
  }
}
