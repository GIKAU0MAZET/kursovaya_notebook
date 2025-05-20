import 'package:flutter/material.dart';
import 'package:kursovaya_notebook/feature/schedule/ui/widget/add_event_dialog_state.dart';

class AddEventDialog extends StatefulWidget {
  final int dayNumber;
  final List<int> availablePairs;
  final List<TimeOfDay> pairTimes;

  const AddEventDialog({
    super.key,
    required this.dayNumber,
    required this.availablePairs,
    required this.pairTimes,
  });

  @override
  AddEventDialogState createState() => AddEventDialogState();
}

//TODO заменить на Stateless
