import 'package:flutter/material.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
    required this.gender,
    required this.iconData,
    required this.isSelected,
  });

  final String gender;
  final IconData iconData;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 2),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: isSelected ? Colors.white : Colors.orange,
            size: 110,
          ),
          const SizedBox(height: 16),
          Text(
            gender,
            style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: isSelected ? Colors.white : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
