import 'package:flutter/material.dart';

import '/screens/custom_widgets/custom_container.dart';
import '../widgets/weight_slider.dart';

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
            const SizedBox(height: 24),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(244, 244, 244, 1.0),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 1),
                      ],
                    ),
                    child: WeightSlider(
                      itemWidth: 40,
                      minValue: 1,
                      maxValue: 250,
                      onChanged: (val) => changeWeight(val),
                      initialHeight: weight!,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
