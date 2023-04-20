// ignore_for_file: sort_child_properties_last

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HeightSlider extends StatelessWidget {
  HeightSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.initialHeight,
    required this.onHeightChanged,
    required this.itemWidth,
  }) : scrollController = ScrollController(initialScrollOffset: (initialHeight - minValue) * itemWidth); // 104

  final int minValue;
  final int maxValue;
  final int initialHeight;
  final ValueChanged<int> onHeightChanged;
  final double itemWidth;
  final ScrollController scrollController;

  double get itemExtent => itemWidth; //100

  int _indexToValue(int index) => minValue + (index - 1); //index

  @override
  build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3; // 252
    return NotificationListener(
      onNotification: _onNotification,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          int itemValue = _indexToValue(index); // index
          bool isExtra = index == 0 || index == itemCount - 1; //0 and after 250

          return isExtra
              ? Container() //empty first and last element
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _animateTo(itemValue, durationMillis: 50),
                  child: Column(
                    children: [
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            itemValue.toString(),
                            style: _getTextStyle(context, itemValue),
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        flex: itemValue == initialHeight ? 3 : 1,
                        child: Container(
                          width: itemValue == initialHeight ? 2 : 1,
                          decoration: BoxDecoration(
                            color: itemValue == initialHeight ? Colors.orange : Colors.black26,
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }

  TextStyle _getDefaultTextStyle() {
    return const TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 14.0,
    );
  }

  TextStyle _getHighlightTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.orange,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle _getTextStyle(BuildContext context, int itemValue) {
    return itemValue == initialHeight ? _getHighlightTextStyle(context) : _getDefaultTextStyle();
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification && notification.direction == ScrollDirection.idle && scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + (itemWidth * 1.5)) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));
    return middleValue;
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != initialHeight) {
        onHeightChanged(middleValue); //update selection
      }
    }
    return true;
  }
}
