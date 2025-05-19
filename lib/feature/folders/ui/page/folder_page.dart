import 'package:flutter/material.dart';

class FolderPage extends StatelessWidget {
  final String folderId;
  const FolderPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    // Заглушка с предметами - в реальности данные стоит брать из Cubit/API
    final subjects = _getSubjectsForFolder(folderId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Папка $folderId'),
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(subjects[index]),
        ),
      ),
    );
  }

  List<String> _getSubjectsForFolder(String folderId) {
    // Пример реализации - в реальности используйте данные из Cubit
    return {
      '1': ['Математика', 'Физика', 'Программирование'],
      '2': ['Базы данных', 'Алгоритмы', 'Сети'],
    }[folderId] ?? [];
  }
}