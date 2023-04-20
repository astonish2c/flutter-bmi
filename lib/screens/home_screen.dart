import 'package:flutter/material.dart';

import 'components/age_section.dart';
import 'components/gender_section.dart';
import 'components/height_section.dart';
import 'components/result_section.dart';
import 'components/weight_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _gender = 1;
  int _height = 200;
  int _weight = 70;
  int _age = 18;

  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  void _toggleGender(int gender) => setState(() => _gender = gender);

  void _changeHeight(int height) => setState(() => _height = height);

  void _changeWeight(int weight) => setState(() => _weight = weight);

  void _changeAge(int age) => setState(() => _age = age);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      key: scaffoldStateKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.orange,
        title: Text(
          'Flutter BMI Calculator',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    Expanded(
                      child: GenderSection(gender: _gender, toggleGender: _toggleGender),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: HeightSection(initialHeight: _height, changeHeight: _changeHeight),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Row(
                        children: [
                          WeightSection(weight: _weight, changeWeight: _changeWeight),
                          const SizedBox(width: 24),
                          AgeSection(age: _age, changeAge: _changeAge),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            ResultSection(height: _height, age: _age, weight: _weight, scaffoldStateKey: scaffoldStateKey),
          ],
        ),
      ),
    );
  }
}
