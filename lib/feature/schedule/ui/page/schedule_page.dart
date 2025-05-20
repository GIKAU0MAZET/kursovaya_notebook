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
    final existingPairs = events.map((e) => e.pairNumber).toSet().toList();
    existingPairs.sort();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dayName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _AddPairButton(dayNumber: dayNumber, pairTimes: pairTimes),
              ],
            ),
            const Divider(),
            ...existingPairs.map((pairNumber) {
              final time = pairTimes[pairNumber - 1];
              final pairEvents =
                  events.where((e) => e.pairNumber == pairNumber).toList();
              return _PairSlot(
                dayNumber: dayNumber,
                pairNumber: pairNumber,
                time: time,
                events: pairEvents,
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
  final List<ScheduleEvent> events;

  const _PairSlot({
    required this.dayNumber,
    required this.pairNumber,
    required this.time,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Блок с номером пары и временем
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$pairNumber пара',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  time.format(context),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Блок с предметами
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...events.map(
                  (event) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _EventItem(
                      event: event,
                      onRemove:
                          () => context.read<ScheduleCubit>().removeEvent(
                            event.id,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final ScheduleEvent event;
  final VoidCallback onRemove;

  const _EventItem({required this.event, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                event.description,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.visibility_off, size: 20),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _AddPairButton extends StatelessWidget {
  final int dayNumber;
  final List<TimeOfDay> pairTimes;

  const _AddPairButton({required this.dayNumber, required this.pairTimes});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (context) => _AddEventDialog(
                dayNumber: dayNumber,
                availablePairs: List.generate(7, (index) => index + 1),
                pairTimes: pairTimes,
              ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        height: 40,
        width: 64,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.add, size: 20),
      ),
    );
  }
}

class _AddEventDialog extends StatefulWidget {
  final int dayNumber;
  final List<int> availablePairs;
  final List<TimeOfDay> pairTimes;

  const _AddEventDialog({
    required this.dayNumber,
    required this.availablePairs,
    required this.pairTimes,
  });

  @override
  __AddEventDialogState createState() => __AddEventDialogState();
}

class __AddEventDialogState extends State<_AddEventDialog> {
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
