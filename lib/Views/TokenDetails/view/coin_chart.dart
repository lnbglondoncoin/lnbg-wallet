
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:       SizedBox(
           // height: 2,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 16.h),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value == 100 ||
                              value == 250 ||
                              value == 500 ||
                              value == 750 ||
                              value == 1000 ||
                              value == 1500) {
                            return Text(
                              '\$${value ~/ 1}',
                              style: TextStyle(
                                  color: greyColor3, fontSize: 12),
                            );
                          }
                          return Container();
                        },
                        interval: 250
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          List<String> labels = ["1H", "1D", "1W", "1M", "1Y", "All"];
                          return Text(
                            labels[value.toInt()],
                            style: TextStyle(
                                color: value == 1
                                    ? orange3
                                    : greyColor3,
                                fontWeight: value == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          );
                        },
                        reservedSize: 20,
                        interval: 1,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 5,
                  minY: 100,
                  maxY: 1500,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1500),
                        FlSpot(1, 500),
                        FlSpot(2, 1000),
                        FlSpot(3, 700),
                        FlSpot(4, 1200),
                         FlSpot(5, 250),
                        FlSpot(6, 1100),
                         FlSpot(7, 700),
                      ],
                      isCurved: true,
                      color: orange3,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            lightGreenColor.withOpacity(0.08),
                            whiteColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
      
    );
  }
}
