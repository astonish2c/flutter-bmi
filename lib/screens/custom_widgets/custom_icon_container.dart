import 'package:flutter/material.dart';

class CustomIconContainer extends StatelessWidget {
  const CustomIconContainer({super.key, required this.iconData, required this.onPressed});

  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.white, blurRadius: 1),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(iconData, color: Colors.orange),
      ),
    );
  }
}
