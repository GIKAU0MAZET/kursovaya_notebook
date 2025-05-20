import 'package:flutter/material.dart';
import 'package:kursovaya_notebook/feature/schedule/data/model/schedule_model.dart';
import 'package:kursovaya_notebook/feature/schedule/ui/widget/add_pair_button.dart';
import 'package:kursovaya_notebook/feature/schedule/ui/widget/pair_slot.dart';

class DaySchedule extends StatelessWidget {
  final int dayNumber;
  final String dayName;
  final List<TimeOfDay> pairTimes;
  final List<ScheduleEvent> events;

  const DaySchedule({
    super.key,
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
                AddPairButton(dayNumber: dayNumber, pairTimes: pairTimes),
              ],
            ),
            const Divider(),
            ...existingPairs.map((pairNumber) {
              final time = pairTimes[pairNumber - 1];
              final pairEvents =
                  events.where((e) => e.pairNumber == pairNumber).toList();
              return PairSlot(
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
