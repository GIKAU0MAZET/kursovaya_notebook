// import 'package:flutter/material.dart';
// import 'package:kursovaya_notebook/feature/schedule/data/model/schedule_model.dart';

// class AddScheduleDialog extends StatefulWidget {
//   final ScheduleEvent? event;
//   const AddScheduleDialog({super.key, this.event});

//   @override
//   _AddScheduleDialogState createState() => _AddScheduleDialogState();
// }

// class _AddScheduleDialogState extends State<AddScheduleDialog> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _titleController;
//   late final TextEditingController _descController;
//   late TimeOfDay _selectedTime;
//   late List<int> _selectedDays;
//   late Color _selectedColor;

//   final _daysOfWeek = {
//     1: 'Понедельник',
//     2: 'Вторник',
//     3: 'Среда',
//     4: 'Четверг',
//     5: 'Пятница',
//     6: 'Суббота',
//     7: 'Воскресенье',
//   };

//   final List<Color> _availableColors = [
//     Colors.red,
//     Colors.blue,
//     Colors.green,
//     Colors.orange,
//     Colors.purple,
//     Colors.teal,
//     Colors.pink,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController(text: widget.event?.title ?? '');
//     _descController = TextEditingController(text: widget.event?.description ?? '');
//     _selectedTime = widget.event?.time ?? TimeOfDay.now();
//     _selectedDays = widget.event?.daysOfWeek.toList() ?? [];
//     _selectedColor = widget.event?.color ?? Colors.blue;
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.event == null ? 'Добавить событие' : 'Редактировать событие'),
//       content: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(labelText: 'Название*'),
//                 validator: (value) => value?.isEmpty ?? true ? 'Введите название' : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _descController,
//                 decoration: const InputDecoration(labelText: 'Описание'),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 16),
//               ListTile(
//                 title: const Text('Время*'),
//                 trailing: Text(_selectedTime.format(context)),
//                 onTap: () async {
//                   final time = await showTimePicker(
//                     context: context,
//                     initialTime: _selectedTime,
//                   );
//                   if (time != null) {
//                     setState(() => _selectedTime = time);
//                   }
//                 },
//               ),
//               const Divider(),
//               const Text('Дни недели*', style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               ..._daysOfWeek.entries.map(
//                 (entry) => CheckboxListTile(
//                   title: Text(entry.value),
//                   value: _selectedDays.contains(entry.key),
//                   onChanged: (checked) {
//                     setState(() {
//                       if (checked ?? false) {
//                         _selectedDays.add(entry.key);
//                       } else {
//                         _selectedDays.remove(entry.key);
//                       }
//                     });
//                   },
//                 ),
//               ),
//               const Divider(),
//               const Text('Цвет', style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: _availableColors
//                     .map((color) => _buildColorChoice(color))
//                     .toList(),
//               ),
//               if (_selectedDays.isEmpty)
//                 const Padding(
//                   padding: EdgeInsets.only(top: 8),
//                   child: Text(
//                     'Выберите хотя бы один день',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Отмена'),
//         ),
//         ElevatedButton(
//           onPressed: _saveEvent,
//           child: const Text('Сохранить'),
//         ),
//       ],
//     );
//   }

//   Widget _buildColorChoice(Color color) {
//     return GestureDetector(
//       onTap: () => setState(() => _selectedColor = color),
//       child: CircleAvatar(
//         backgroundColor: color,
//         radius: 16,
//         child: _selectedColor == color
//             ? const Icon(Icons.check, color: Colors.white, size: 16)
//             : null,
//       ),
//     );
//   }

//   void _saveEvent() {
//     if (!(_formKey.currentState?.validate() ?? false)) return;
//     if (_selectedDays.isEmpty) return;

//     final event = ScheduleEvent(
//       id: widget.event?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
//       title: _titleController.text,
//       description: _descController.text,
//       time: _selectedTime,
//       daysOfWeek: _selectedDays,
//       color: _selectedColor,
//     );

//     Navigator.pop(context, event);
//   }
// }