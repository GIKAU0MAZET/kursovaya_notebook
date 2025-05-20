import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  const EditableField({
    super.key,
    required this.context,
    required this.label,
    required this.controller,
    required this.onSaved,
  });

  final BuildContext context;
  final String label;
  final TextEditingController controller;
  final Function(String p1) onSaved;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            onSaved(controller.text);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Изменения для "$label" сохранены')),
            );
          },
        ),
      ],
    );
  }
}
