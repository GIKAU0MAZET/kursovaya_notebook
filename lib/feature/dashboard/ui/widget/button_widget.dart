import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.isActive,
  });

  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(icon, size: 24, color: isActive ? Colors.black : Colors.grey),
          SizedBox(height: 4),
          Text(
            text,
            style: TextStyle(color: isActive ? Colors.black : Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
