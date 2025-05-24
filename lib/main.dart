import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kursovaya_notebook/core/router/app_router.dart';
import 'package:kursovaya_notebook/feature/dashboard/bloc/dashboard_cubit.dart';
import 'package:kursovaya_notebook/feature/folders/data/model/folder_model.dart';
import 'package:kursovaya_notebook/feature/note/bloc/note_bloc.dart';
import 'package:kursovaya_notebook/feature/note/data/model/note_model.dart';
import 'package:kursovaya_notebook/feature/schedule/bloc/schedule_cubit.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';
import 'package:kursovaya_notebook/feature/subjects/data/model/subject_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(FolderAdapter());
  Hive.registerAdapter(SubjectAdapter());

  final noteBox = await Hive.openBox<Note>('notesBox');
  final folderBox = await Hive.openBox<Folder>('foldersBox');
  final subjectBox = await Hive.openBox<Subject>('subjectsBox');

  runApp(
    AppWidget(noteBox: noteBox, subjectBox: subjectBox, folderBox: folderBox),
  );
}

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
    required this.noteBox,
    required this.subjectBox,
    required this.folderBox,
  });

  final Box<Note> noteBox;
  final Box<Subject> subjectBox;
  final Box<Folder> folderBox;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        DashboardCubit.provider(folderBox),
        SubjectCubit.provider(subjectBox),
        ScheduleCubit.provider(),
        NoteCubit.provider(noteBox),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.config,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
