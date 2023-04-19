import 'package:flutter/material.dart';

import '../custom_widgets/custom_container.dart';

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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.orange : Colors.grey,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.orange,
            size: 110,
          ),
          const SizedBox(height: 16),
          Text(
            gender,
            style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700, letterSpacing: 1.2),
          ),
        ],
      ),
    );
  }
}
