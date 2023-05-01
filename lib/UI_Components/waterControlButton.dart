import 'package:flutter/material.dart';
import 'package:irrigation_control_panel/globalConstants.dart' as global;
class PumpControlButton extends StatefulWidget {
  PumpControlButton({Key? key, required this.waterOn}) : super(key: key);
  final bool waterOn;
  @override
  State<PumpControlButton> createState() => _PumpControlButtonState(waterOn);
}

class _PumpControlButtonState extends State<PumpControlButton> {
  _PumpControlButtonState(this.waterOn);
  bool waterOn = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: global.deviceHeight / 12,
        width: global.deviceWidth / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black, width: 1.5),
          color: waterOn? Color(0xff17D4EE) : Color(0xffBFE7ED),
        ),
        child: Center(
          child: Text(
            waterOn? 'ON' : 'OFF',
            style: TextStyle(
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold,
                fontSize: 26),
          ),
        ),
      ),
      onTap: (){
        setState(() {
          waterOn = !waterOn;
        });
      },
    );
  }
}
