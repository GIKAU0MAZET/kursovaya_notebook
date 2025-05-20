import 'package:flutter/material.dart';
import 'package:kursovaya_notebook/feature/schedule/data/model/schedule_model.dart';

class EventItem extends StatelessWidget {
  final ScheduleEvent event;
  final VoidCallback onRemove;

  const EventItem({super.key, required this.event, required this.onRemove});

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
