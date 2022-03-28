import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracer/components/icon_content.dart';
import 'package:health_tracer/components/reusable_card.dart';
import 'package:health_tracer/constants.dart';
import 'package:health_tracer/screens/results_page.dart';
import 'package:health_tracer/components/bottom_button.dart';
import 'package:health_tracer/components/round_icon_button.dart';
import 'package:health_tracer/calculator_brain.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender = Gender.male;
  int height = 180;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: ReusableCard(
                  selectedGender == Gender.male
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  IconContent(
                    FontAwesomeIcons.mars,
                    'MALE',
                  ),
                  () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                )),
                Expanded(
                  child: ReusableCard(
                    selectedGender == Gender.female
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    IconContent(FontAwesomeIcons.venus, 'FEMALE'),
                    () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ReusableCard(
                  kActiveCardColour,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'HEIGHT',
                        style: kLabelTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            height.toString(),
                            style: kNumberTextStyle,
                          ),
                          Text(
                            'cm',
                            style: kLabelTextStyle,
                          )
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Color(0xFF8D8E98),
                          activeTrackColor: Colors.white,
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Slider(
                          value: height.toDouble(),
                          min: 120.0,
                          max: 220.0,
                          onChanged: (double newValue) {
                            setState(() {
                              height = newValue.round();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  () {})),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                      kActiveCardColour,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(FontAwesomeIcons.minus, () {
                                setState(() {
                                  weight--;
                                });
                              }),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                FontAwesomeIcons.plus,
                                () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      () {}),
                ),
                Expanded(
                  child: ReusableCard(
                      kActiveCardColour,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'AGE',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                FontAwesomeIcons.minus,
                                () {
                                  setState(
                                    () {
                                      age--;
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(FontAwesomeIcons.plus, () {
                                setState(() {
                                  age++;
                                });
                              })
                            ],
                          )
                        ],
                      ),
                      () {}),
                ),
              ],
            ),
          ),
          BottomButton(() {
            CalculatorBrain calc =
                CalculatorBrain(height,weight);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsPage(
                  calc.getInterpretation(),
                  calc.calculateBMI(),
                  calc.getResult(),
                ),
              ),
            );
          }, 'CALCULATE'),
        ],
      ),
    );
  }
}