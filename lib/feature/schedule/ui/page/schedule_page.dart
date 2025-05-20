// schedule_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/schedule/bloc/schedule_cubit.dart';
import 'package:kursovaya_notebook/feature/schedule/data/model/schedule_model.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  static const path = '/schedule';
  final Map<int, String> daysOfWeek = const {
    1: 'Понедельник',
    2: 'Вторник',
    3: 'Среда',
    4: 'Четверг',
    5: 'Пятница',
    6: 'Суббота',
  };

  final List<TimeOfDay> pairTimes = const [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 9, minute: 45),
    TimeOfDay(hour: 11, minute: 30),
    TimeOfDay(hour: 13, minute: 30),
    TimeOfDay(hour: 15, minute: 15),
    TimeOfDay(hour: 17, minute: 0),
    TimeOfDay(hour: 18, minute: 45),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Расписание')),
      body: BlocBuilder<ScheduleCubit, List<ScheduleEvent>>(
        builder: (context, events) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: daysOfWeek.length,
            itemBuilder: (context, index) {
              final day = index + 1;
              return _DaySchedule(
                dayNumber: day,
                dayName: daysOfWeek[day]!,
                pairTimes: pairTimes,
                events: events.where((e) => e.day == day).toList(),
              );
            },
          );
        },
      ),
    );
  }
}

class _DaySchedule extends StatelessWidget {
  final int dayNumber;
  final String dayName;
  final List<TimeOfDay> pairTimes;
  final List<ScheduleEvent> events;

  const _DaySchedule({
    required this.dayNumber,
    required this.dayName,
    required this.pairTimes,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dayName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...pairTimes.asMap().entries.map((entry) {
              final pairNumber = entry.key + 1;
              final time = entry.value;
              final ScheduleEvent? event = events
                  .cast<ScheduleEvent?>()
                  .firstWhere(
                    (e) => e?.pairNumber == pairNumber,
                    orElse: () => null,
                  );

              return _PairSlot(
                dayNumber: dayNumber,
                pairNumber: pairNumber,
                time: time,
                event: event,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PairSlot extends StatelessWidget {
  final int dayNumber;
  final int pairNumber;
  final TimeOfDay time;
  final ScheduleEvent? event;

  const _PairSlot({
    required this.dayNumber,
    required this.pairNumber,
    required this.time,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              '${pairNumber} пара\n${time.format(context)}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child:
                event != null
                    ? _EventItem(event: event!)
                    : _AddButton(dayNumber: dayNumber, pairNumber: pairNumber),
          ),
        ],
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final ScheduleEvent event;

  const _EventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (event.description.isNotEmpty)
                  Text(
                    event.description,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.visibility_off, size: 20),
            onPressed:
                () => context.read<ScheduleCubit>().removeEvent(event.id),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final int dayNumber;
  final int pairNumber;

  const _AddButton({required this.dayNumber, required this.pairNumber});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showAddDialog(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.add, size: 20),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) =>
              _AddEventDialog(dayNumber: dayNumber, pairNumber: pairNumber),
    );
  }
}

class _AddEventDialog extends StatefulWidget {
  final int dayNumber;
  final int pairNumber;

  const _AddEventDialog({required this.dayNumber, required this.pairNumber});

  @override
  __AddEventDialogState createState() => __AddEventDialogState();
}

class __AddEventDialogState extends State<_AddEventDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить предмет'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                pairNumber: widget.pairNumber,
                time: TimeOfDay(
                  hour:
                      8 +
                      (widget.pairNumber - 1) ~/ 2 * 2 +
                      (widget.pairNumber - 1) % 2 * 1,
                  minute: (widget.pairNumber - 1) % 2 == 0 ? 0 : 45,
                ),
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

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
