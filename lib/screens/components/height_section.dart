import 'package:flutter/material.dart';

import '/screens/custom_widgets/custom_container.dart';
import '../custom_widgets/height_slider.dart';

class HeightSection extends StatelessWidget {
  const HeightSection({super.key, required this.height, required this.changeHeight});

  final int? height;
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
                child: HeightSlider(
                  width: 100,
                  minValue: 1,
                  maxValue: 250,
                  onChanged: (val) => changeHeight(val),
                  value: height!,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
