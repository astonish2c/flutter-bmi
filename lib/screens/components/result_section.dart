import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../custom_widgets/custom_icon_container.dart';

class ResultSection extends StatefulWidget {
  const ResultSection({super.key, required this.weight, required this.height, required this.age, required this.scaffoldStateKey});

  final int weight, height, age;
  final GlobalKey<ScaffoldState> scaffoldStateKey;

  @override
  State<ResultSection> createState() => _ResultSectionState();
}

class _ResultSectionState extends State<ResultSection> {
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 70,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          final double bmi = widget.weight / pow((widget.height / 100), 2);
          final String message;
          final String category;

          if (bmi < 18.5) {
            message = 'Seek advice from a healthcare professional and make changes to reach a healthy weight.';
            category = 'underweight';
          } else if (bmi < 24.9) {
            message = 'Congratulations on maintaining a healthy weight! Keep prioritizing balanced eating and regular exercise.';
            category = 'Healthy';
          } else {
            message = 'Reduce calorie intake and increase physical activity to reach a healthy BMI. Consult a healthcare professional for guidance.';
            category = 'overweight';
          }

          widget.scaffoldStateKey.currentState!.showBottomSheet(
            constraints: const BoxConstraints(maxHeight: 500),
            (context) {
              return Screenshot(
                controller: _screenshotController,
                child: CustomBottomSheet(theme: theme, bmi: bmi, category: category, message: message, screenshotController: _screenshotController, widget: widget, mounted: mounted),
              );
            },
          );
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.orange,
        ),
        child: Text(
          'Calculate BMI'.toUpperCase(),
          style: theme.textTheme.titleLarge!.copyWith(fontSize: 24, letterSpacing: 1.2),
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.theme,
    required this.bmi,
    required this.category,
    required this.message,
    required ScreenshotController screenshotController,
    required this.widget,
    required this.mounted,
  }) : _screenshotController = screenshotController;

  final ThemeData theme;
  final double bmi;
  final String category;
  final String message;
  final ScreenshotController _screenshotController;
  final ResultSection widget;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.orange,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Your BMI is',
                style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                bmi.toStringAsFixed(2),
                style: theme.textTheme.titleLarge!.copyWith(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text('($category)'.toUpperCase(), style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconContainer(
                    iconData: Icons.download_rounded,
                    onPressed: () async {
                      await [Permission.storage].request();

                      final image = await _screenshotController.captureFromWidget(this, pixelRatio: 2);

                      final String name = 'Screenshot${DateTime.now().toString()}';

                      await ImageGallerySaver.saveImage(image, name: name);

                      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Screenshot saved in Gallery.')));
                    },
                  ),
                  const SizedBox(width: 24),
                  CustomIconContainer(
                    iconData: Icons.share_rounded,
                    onPressed: () async {
                      final Uint8List image = await _screenshotController.captureFromWidget(this, pixelRatio: 2);
                      final directory = await getApplicationDocumentsDirectory();
                      final File savedImage = File('${directory.path}/flutter.png');

                      savedImage.writeAsBytesSync(image);

                      await Share.shareFiles([savedImage.path]);
                    },
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Colors.white, blurRadius: 1),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
