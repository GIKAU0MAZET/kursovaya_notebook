import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/schedule/bloc/schedule_cubit.dart';
import 'package:kursovaya_notebook/feature/schedule/data/model/schedule_model.dart';
import 'package:kursovaya_notebook/feature/schedule/ui/widget/event_item.dart';

class PairSlot extends StatelessWidget {
  final int dayNumber;
  final int pairNumber;
  final TimeOfDay time;
  final List<ScheduleEvent> events;

  const PairSlot({
    super.key,
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
            width: 70,
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
                    padding: const EdgeInsets.only(bottom: 4),
                    child: EventItem(
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
