import 'package:flutter/material.dart';

import '../widgets/gender_widget.dart';

class GenderSection extends StatelessWidget {
  const GenderSection({super.key, required this.gender, required this.toggleGender});

  final int? gender;
  final Function toggleGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => toggleGender(1),
            child: GenderWidget(
              gender: 'Male',
              iconData: Icons.male_rounded,
              isSelected: gender == 1,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: GestureDetector(
            onTap: () => toggleGender(2),
            child: GenderWidget(
              gender: 'Female',
              iconData: Icons.female_rounded,
              isSelected: gender == 2,
            ),
          ),
        ),
      ],
    );
  }
}
