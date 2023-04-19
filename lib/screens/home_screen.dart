// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'components/age_section.dart';
import 'components/gender_section.dart';
import 'components/height_section.dart';
import 'components/weight_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _gender = 1;
  int _height = 170;
  int _weight = 70;
  int _age = 18;

  void _toggleGender(int gender) {
    setState(() {
      _gender = gender;
    });
  }

  void _changeHeight(int height) {
    setState(() {
      _height = height;
    });
  }

  void _changeWeight(int weight) {
    setState(() {
      _weight = weight;
    });
  }

  void _changeAge(int age) => setState(() => _age = age);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
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
                    SizedBox(height: 24),
                    Expanded(
                      child: HeightSection(height: _height, changeHeight: _changeHeight),
                    ),
                    SizedBox(height: 24),
                    Expanded(
                      child: Row(
                        children: [
                          WeightSection(weight: _weight, changeWeight: _changeWeight),
                          SizedBox(width: 24),
                          AgeSection(age: _age, changeAge: _changeAge),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'Calculate BMI'.toUpperCase(),
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 24, letterSpacing: 1.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
