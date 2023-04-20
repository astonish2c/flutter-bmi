import 'dart:async';

import 'package:flutter/material.dart';

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
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
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
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 1),
        ],
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
