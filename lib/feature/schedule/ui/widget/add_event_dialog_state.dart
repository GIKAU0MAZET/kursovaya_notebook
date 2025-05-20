import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/schedule/bloc/schedule_cubit.dart';
import 'package:kursovaya_notebook/feature/schedule/data/model/schedule_model.dart';
import 'package:kursovaya_notebook/feature/schedule/ui/widget/add_event_dialog.dart';

class AddEventDialogState extends State<AddEventDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _selectedPairNumber = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить предмет'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              value: _selectedPairNumber,
              items:
                  widget.availablePairs
                      .map(
                        (pairNumber) => DropdownMenuItem(
                          value: pairNumber,
                          child: Text('$pairNumber пара'),
                        ),
                      )
                      .toList(),
              onChanged:
                  (value) => setState(() => _selectedPairNumber = value!),
              decoration: const InputDecoration(
                labelText: 'Номер пары',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название предмета*',
                border: OutlineInputBorder(),
              ),
              validator:
                  (value) =>
                      value?.isEmpty ?? true ? 'Обязательное поле' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Описание (необязательно)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final event = ScheduleEvent(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                title: _titleController.text,
                description: _descController.text,
                day: widget.dayNumber,
                pairNumber: _selectedPairNumber,
              );
              context.read<ScheduleCubit>().addEvent(event);
              Navigator.pop(context);
            }
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
