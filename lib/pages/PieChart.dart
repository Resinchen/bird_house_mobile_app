import 'package:birdhouseapp/domains/birdHouse.dart';
import 'package:birdhouseapp/utils/generatorHexColor.dart';
import 'package:birdhouseapp/widgets/indicator.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  final BirdHouse birdhouse;

  const PieChartWidget({Key key, this.birdhouse}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartWidgetState();
}

class PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex;
  BirdHouse birdHouse;

  @override
  void initState() {
    super.initState();
    setState(() {
      birdHouse = widget.birdhouse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: generateIndicators(),
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateIndicators() {
    return birdHouse.visiters.keys
            .map((e) => [
                  Indicator(
                    color: GeneratorHexColor.generate(),
                    text: e,
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  )
                ])
            .expand((element) => element)
            .toList() +
        [SizedBox(height: 18)];
  }

  List<PieChartSectionData> showingSections() {
    return birdHouse.visiters.entries
        .map((e) => PieChartSectionData(
              color: GeneratorHexColor.generate(),
              value: e.value + .0,
              title: e.value.toString(),
              radius: 50,
              titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            ))
        .toList();
  }
}
