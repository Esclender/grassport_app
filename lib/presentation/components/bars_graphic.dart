import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class _BarData {
  const _BarData(this.color, this.value, this.shadowValue, this.name,
      {this.imageURL =
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/profile-ddefault.png?alt=media&token=36401350-8ef2-4483-b277-c3a17461e780'});
  final Color color;
  final double value;
  final double shadowValue;
  final String name;
  final String imageURL;
}

class BarGraphic extends StatefulWidget {
  BarGraphic({Key? key}) : super(key: key);

  final dataList = [
    _BarData(c5, 18, 18, 'Esclender'),
    _BarData(c13, 17, 8, 'Esclender'),
    _BarData(c2, 10, 15, 'Esclender'),
  ];

  @override
  State<BarGraphic> createState() => _BarGraphicState();
}

class _BarGraphicState extends State<BarGraphic> {
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Top usuarios',
          style: TextStyle(color: c1),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: 300,
        decoration: BoxDecoration(
          color: c8,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AspectRatio(
            aspectRatio: 2.0,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                borderData: FlBorderData(
                  show: true,
                  border: const Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: c1),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return bottomTitle(
                          widget.dataList[index].name,
                          widget.dataList[index].imageURL,
                          meta,
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: c1,
                    strokeWidth: 1,
                  ),
                ),
                barGroups: widget.dataList.asMap().entries.map((e) {
                  final index = e.key;
                  final data = e.value;
                  return generateBarGroup(
                    index,
                    data.color,
                    data.value,
                    data.shadowValue,
                  );
                }).toList(),
                maxY: 50,
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchTooltipData: BarTouchTooltipData(
                    fitInsideHorizontally: true,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        'Esclender',
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: rod.color,
                          fontSize: 12,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomTitle(
    String name,
    String imgURL,
    TitleMeta meta,
  ) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imgURL),
            radius: 14,
          ),
        ],
      ),
    );
  }

  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: value,
        color: color,
        width: 6,
      ),
    ], showingTooltipIndicators: [
      0
    ]);
  }
}
