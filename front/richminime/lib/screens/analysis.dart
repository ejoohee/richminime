import 'package:flutter/material.dart';
import 'package:richminime/models/analysis_model.dart';
import 'package:richminime/widgets/appbar_back_home.dart';
import 'package:richminime/services/analysis.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

final List<Color> colorList = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.pink,
  Colors.blueGrey,
  Colors.purple,
  Colors.orange,
];

class _AnalysisState extends State<Analysis> {
  SpendingData? spendingData;
  final AnalysisService analysisService = AnalysisService();
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      spendingData = await analysisService.getSpendingData();
      setState(() {});
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final month = spendingData?.month;
    final totalAmount = spendingData?.totalAmount?.toDouble() ?? 1.0;

    return Scaffold(
      appBar: AppBarBackHome(title: "$month월의 소비 패턴"),
      body: Center(
        child: spendingData == null
            ? const Text("Loading...")
            : SingleChildScrollView(
                // Added SingleChildScrollView
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      // Added Container to specify PieChart size
                      height: 300, // Height
                      width: 300, // Width
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 1,
                          centerSpaceRadius: 50,
                          sections: spendingData!.spendingAmountList!
                              .asMap()
                              .map(
                                (index, e) => MapEntry(
                                  index,
                                  PieChartSectionData(
                                    color: someColorFunction(e.category, index),
                                    value: e.amount!.toDouble(),
                                    title:
                                        "${((e.amount! / totalAmount) * 100).toStringAsFixed(1)}%",
                                    radius: 100,
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        ),
                        swapAnimationDuration:
                            const Duration(milliseconds: 3000),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: spendingData!.spendingAmountList!
                          .asMap()
                          .map(
                            (index, e) => MapEntry(
                              index,
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0), // 왼쪽에서 16.0만큼 띄움
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color:
                                          someColorFunction(e.category, index),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      e.category!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Color someColorFunction(String? category, int index) {
    return colorList[index % colorList.length];
  }
}
