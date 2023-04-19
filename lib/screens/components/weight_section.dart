import 'package:flutter/material.dart';

import '/screens/custom_widgets/custom_container.dart';
import '/screens/custom_widgets/weight_slider.dart';

class WeightSection extends StatelessWidget {
  const WeightSection({super.key, required this.weight, required this.changeWeight});

  final int? weight;
  final Function changeWeight;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: CustomContainer(
        child: Column(
          children: [
            Text(
              'Weight (kg) ',
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(244, 244, 244, 1.0),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                  ),
                  child: WeightSlider(
                    width: 40,
                    minValue: 1,
                    maxValue: 250,
                    onChanged: (val) => changeWeight(val),
                    value: weight!,
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
