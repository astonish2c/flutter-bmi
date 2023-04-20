import 'package:flutter/material.dart';

import '/screens/custom_widgets/custom_container.dart';
import '../widgets/height_slider.dart';

class HeightSection extends StatelessWidget {
  const HeightSection({super.key, required this.initialHeight, required this.changeHeight});

  final int? initialHeight;
  final Function changeHeight;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CustomContainer(
      child: Column(
        children: [
          Text(
            'Height (cm) ',
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(244, 244, 244, 1.0),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 1)],
              ),
              child: HeightSlider(
                itemWidth: 100,
                minValue: 1,
                maxValue: 250,
                onHeightChanged: (height) => changeHeight(height),
                initialHeight: initialHeight!,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
