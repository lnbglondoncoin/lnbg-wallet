import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Transections/controller/transection_controller.dart';

class ChartScreen extends StatelessWidget {
   ChartScreen({super.key});
final transactionController = Get.put(TransactionController());
  @override
  Widget build(BuildContext context) {
         var theme = Theme.of(context);
   
       bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode?lightBlackColor3:whiteColor,
      body:       SizedBox(
           // height: 2,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 16.h),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
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
    String formattedValue = value >= 1000 ? "${(value / 1000).toStringAsFixed(1)}k" : "\$${value.toInt()}";
    return Text(
      formattedValue,
      style: GoogleFonts.urbanist(
          color: isDarkMode ? greyColor : greyColor3,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500),
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
                            style: GoogleFonts.urbanist(
                              fontSize: 14.sp,
                                color: value == 1
                                    ?isDarkMode?lightGreenColor: orange3
                                    :isDarkMode?greyColor: greyColor3,
                                fontWeight: value == 1
                                    ? FontWeight.w700
                                    : FontWeight.w800),
                          );
                        },
                        reservedSize: 20,
                        interval: 1,
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 5,
                  minY: 100,
                  maxY: 1500,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                         FlSpot(0, transactionController.avg1Hour.value),
                         FlSpot(1, transactionController.avg1Day.value),
                         FlSpot(2, transactionController.avg1Week.value),
                         FlSpot(3, transactionController.avg1Month.value),
                         FlSpot(4, transactionController.avg1Year.value),
                           FlSpot(5, transactionController.avgTotal.value),
                        //  FlSpot(6, 1100),
                        //   FlSpot(7, 700),
                      ],
                      isCurved: true,
                      color:isDarkMode?lightGreenColor: orange3,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            lightGreenColor.withOpacity(0.08),
                          isDarkMode?lightBlackColor3:  whiteColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
      
    );
  }
}
