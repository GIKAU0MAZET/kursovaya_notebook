import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/schedule/bloc/schedule_cubit.dart';
import 'package:kursovaya_notebook/feature/schedule/data/model/schedule_model.dart';
import 'package:kursovaya_notebook/feature/schedule/ui/widget/day_schedule.dart';

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
              return DaySchedule(
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
