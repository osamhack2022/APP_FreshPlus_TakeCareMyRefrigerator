import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomepageGauge extends StatefulWidget {
  const HomepageGauge({Key? key}) : super(key: key);
  _HomepageGaugeState createState() => _HomepageGaugeState();
}

class _HomepageGaugeState extends State<HomepageGauge> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 156.0,
        width: 156.0,
        child: Center(
            child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
                showLabels: false,
                showAxisLine: false,
                showTicks: false,
                minimum: 0,
                maximum: 99,
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 33,
                      color: Color(0xFFFE2A25),
                      label: '위험',
                      sizeUnit: GaugeSizeUnit.factor,
                      labelStyle:
                          GaugeTextStyle(fontFamily: 'Times', fontSize: 20),
                      startWidth: 0.65,
                      endWidth: 0.65),
                  GaugeRange(
                    startValue: 33,
                    endValue: 66,
                    color: Color(0xFFFFBA00),
                    label: '양호',
                    labelStyle:
                        GaugeTextStyle(fontFamily: 'Times', fontSize: 20),
                    startWidth: 0.65,
                    endWidth: 0.65,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                  GaugeRange(
                    startValue: 66,
                    endValue: 99,
                    color: Color(0xFF00AB47),
                    label: '안전',
                    labelStyle:
                        GaugeTextStyle(fontFamily: 'Times', fontSize: 20),
                    sizeUnit: GaugeSizeUnit.factor,
                    startWidth: 0.65,
                    endWidth: 0.65,
                  ),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(value: 99)
                ])
          ],
        )));
  }
}
