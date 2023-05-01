import 'package:flutter/material.dart';
import 'package:irrigation_control_panel/UI_Components/GuageBox.dart';
import 'package:irrigation_control_panel/UI_Components/waterControlButton.dart';
import 'package:irrigation_control_panel/globalConstants.dart' as global;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  final bool _waterOn = false;
  final double _humidityValue = 30;
  final double _temperatureValue = 20;
  final double _moistureValue = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
        title: Text('Control Panel'),
        titleTextStyle: TextStyle(
            fontFamily: 'Jost',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        elevation: 0,
        backgroundColor: Color(0xffF8AE00),
      ),
      backgroundColor: Color(0xffFBF1E1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Analytical Readings :',
                      style: TextStyle(fontSize: 22),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GuageComponent(
                  guageBoxColor: Color(0xff0099FA),
                  guageBoxValue: _humidityValue,
                  guageBoxTitle: 'Humidity',
                  guageBoxImage: AssetImage("assets/images/humidity_color.png"),
                ),
                GuageComponent(
                  guageBoxColor: Color(0xffE54C3C),
                  guageBoxValue: _temperatureValue,
                  guageBoxTitle: 'Temperature',
                  guageBoxImage:
                      AssetImage("assets/images/temperature_color.png"),
                ),
              ],
            ),
            GuageComponent(
              guageBoxColor: Color(0xff01C09A),
              guageBoxValue: _moistureValue,
              guageBoxTitle: 'Moisture',
              guageBoxImage:
                  AssetImage("assets/images/moisture_plant_color.png"),
            ),
            Divider(
              color: Colors.grey.shade400,
              indent: 5,
              endIndent: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pump Control :',
                style: TextStyle(fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: PumpControlButton(waterOn: _waterOn)
            ),
          ],
        ),
      ),
    );
  }
}
