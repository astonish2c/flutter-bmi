// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import '../custom_widgets/custom_container.dart';
import '../custom_widgets/custom_icon_button.dart';

class AgeSection extends StatelessWidget {
  const AgeSection({
    super.key,
    required this.age,
    required this.changeAge,
  });

  final int? age;
  final Function changeAge;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: CustomContainer(
        child: Column(
          children: [
            Text(
              'Age',
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            Row(
              children: [
                CustomIconButton(
                  iconData: Icons.remove,
                  onPressed: () => changeAge(age! - 1),
                  onLongPress: () => changeAge(age! - 1),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$age',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 48, color: Colors.orange),
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  onPressed: () => changeAge(age! + 1),
                  onLongPress: () => changeAge(age! + 1),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
