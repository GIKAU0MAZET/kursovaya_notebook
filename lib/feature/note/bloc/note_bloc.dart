import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kursovaya_notebook/feature/note/bloc/note_state.dart';
import 'package:kursovaya_notebook/feature/note/data/model/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteCubit extends Cubit<NoteState> {
  final Box<Note> noteBox;

  NoteCubit(this.noteBox) : super(NoteState(notes: [])) {
    loadNotes(); // загружаем при старте
  }

  void loadNotes() {
    final notes = noteBox.values.toList();
    emit(state.copyWith(notes: notes));
  }

  void addNote(String subjectId, String content) {
    final newNote = Note(
      id: const Uuid().v4(),
      subjectId: subjectId,
      content: content,
      createdAt: DateTime.now(),
    );

    noteBox.put(newNote.id, newNote); // сохраняем в Hive
    loadNotes(); // обновляем состояние
  }

  void deleteNote(String noteId) {
    noteBox.delete(noteId); // удаляем из Hive
    loadNotes();
  }

  void updateNote(String noteId, String newContent) {
    final existingNote = noteBox.get(noteId);
    if (existingNote != null) {
      final updatedNote = Note(
        id: existingNote.id,
        subjectId: existingNote.subjectId,
        content: newContent,
        createdAt: existingNote.createdAt,
      );

      noteBox.put(noteId, updatedNote); // обновляем в Hive
      loadNotes();
    }
  }

  static BlocProvider<NoteCubit> provider(Box<Note> noteBox) {
    return BlocProvider(create: (context) => NoteCubit(noteBox));
  }
}
