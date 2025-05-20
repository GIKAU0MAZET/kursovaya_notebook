import 'package:flutter/material.dart';
import 'package:kursovaya_notebook/feature/schedule/ui/widget/add_event_dialog.dart';

class AddPairButton extends StatelessWidget {
  final int dayNumber;
  final List<TimeOfDay> pairTimes;

  const AddPairButton({
    super.key,
    required this.dayNumber,
    required this.pairTimes,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (context) => AddEventDialog(
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
