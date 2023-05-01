import 'package:flutter/material.dart';
import 'package:irrigation_control_panel/globalConstants.dart' as global;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GuageComponent extends StatelessWidget {
  GuageComponent(
      {super.key,
      required this.guageBoxColor,
      required this.guageBoxValue,
      required this.guageBoxTitle,
      required this.guageBoxImage});

  Color guageBoxColor;
  double guageBoxValue;
  String guageBoxTitle;
  ImageProvider guageBoxImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: global.deviceHeight / 4,
      width: global.deviceWidth / 3,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(60),
        color: guageBoxColor,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: global.deviceHeight / 7.5),
            child: SfRadialGauge(
              enableLoadingAnimation: true,
              animationDuration: 2000,
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  ranges: [
                    GaugeRange(
                      startValue: 0,
                      endValue: guageBoxValue,
                      color: Colors.white,
                    ),
                  ],
                  startAngle: 180,
                  endAngle: 0,
                  canScaleToFit: true,
                  axisLineStyle: const AxisLineStyle(
                      color: Colors.black, cornerStyle: CornerStyle.bothFlat),
                  showLabels: false,
                  showTicks: false,
                ),
              ],
            ),
          ),
          Positioned(
            top: global.deviceHeight / 16.1,
            child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Image(
                  image: guageBoxImage,
                )),
          ),
          Positioned(
            bottom: global.deviceHeight / 15.5,
            child: Text(
              guageBoxValue.toString(),
              style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none),
            ),
          ),
          Positioned(
            bottom: global.deviceHeight / 35,
            child: Text(
              guageBoxTitle,
              style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
