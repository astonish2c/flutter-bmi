// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';

import '../custom_widgets/custom_container.dart';

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

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.onLongPress,
  });

  final IconData iconData;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      widget.onLongPress();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child: GestureDetector(
        onTap: widget.onPressed,
        onLongPressStart: (details) {
          _startTimer();
        },
        onLongPressEnd: (details) {
          _stopTimer();
        },
        onLongPress: widget.onPressed,
        child: Icon(widget.iconData, size: 18),
      ),
    );
  }
}
