import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int selectedIndex = 0; // 0 = Day, 1 = Week, 2 = Month

  // Donut chart data (percentages)
  final List<List<double>> donutData = [
    [60, 30, 10], // Day
    [50, 35, 15], // Week
    [70, 20, 10], // Month
  ];

  @override
  Widget build(BuildContext context) {
    final totalLiters = [5, 100, 900];
    final periodText = ["This day", "This week", "This month"];

    final List<double> currentDonut = donutData[selectedIndex];
    final double household = currentDonut[0];
    final double irrigation = currentDonut[1];
    final double other = currentDonut[2];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Statistics",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Toggle Tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedIndex = i),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: selectedIndex == i
                                  ? Colors.blueAccent
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                ["Day", "Week", "Month"][i],
                                style: TextStyle(
                                  color: selectedIndex == i
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Total usage and dropdown
              Row(
                children: [
                  Text(
                    "${totalLiters[selectedIndex]}",
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Liters",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Row(
                    children: const [
                      Text(
                        "All usage",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Bar chart
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final labelsDay = ["1h", "2h", "3h", "4h", "5h", "6h", "7h"];
                            final labelsWeek = [
                              "Mon",
                              "Tue",
                              "Wed",
                              "Thu",
                              "Fri",
                              "Sat",
                              "Sun"
                            ];
                            final labelsMonth = [
                              "W1",
                              "W2",
                              "W3",
                              "W4",
                              "W5",
                              "W6",
                              "W7"
                            ];
                            final labels = selectedIndex == 0
                                ? labelsDay
                                : selectedIndex == 1
                                ? labelsWeek
                                : labelsMonth;
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                labels[value.toInt() % labels.length],
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups: List.generate(7, (i) {
                      final heights = [
                        [2.0, 3.5, 2.0, 5.0, 3.2, 4.5, 2.8],
                        [5.0, 6.2, 7.0, 5.5, 7.8, 8.0, 6.5],
                        [9.0, 8.0, 9.5, 10.0, 8.5, 9.2, 10.0],
                      ];
                      return BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: heights[selectedIndex][i],
                            color: Colors.blueAccent,
                            width: 16,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Donut chart (dynamic)
              Center(
                child: Column(
                  children: [
                    Text(
                      periodText[selectedIndex],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          PieChart(
                            PieChartData(
                              centerSpaceRadius: 60,
                              sectionsSpace: 0,
                              sections: [
                                PieChartSectionData(
                                    color: Colors.blueAccent,
                                    value: household,
                                    radius: 24),
                                PieChartSectionData(
                                    color: Colors.greenAccent,
                                    value: irrigation,
                                    radius: 24),
                                PieChartSectionData(
                                    color: Colors.grey.shade300,
                                    value: other,
                                    radius: 24),
                              ],
                            ),
                          ),
                          Text(
                            "${totalLiters[selectedIndex]} L",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                "Detailed Usage",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 14),

              _buildUsageItem(
                icon: Icons.water_drop,
                label: "Household",
                color: Colors.blueAccent,
                amount: household.toInt(),
                percent: "${household.toInt()}%",
              ),
              _buildUsageItem(
                icon: Icons.grass,
                label: "Irrigation",
                color: Colors.greenAccent,
                amount: irrigation.toInt(),
                percent: "${irrigation.toInt()}%",
              ),
              _buildUsageItem(
                icon: Icons.more_horiz,
                label: "Other",
                color: Colors.grey.shade400,
                amount: other.toInt(),
                percent: "${other.toInt()}%",
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsageItem({
    required IconData icon,
    required String label,
    required Color color,
    required int amount,
    required String percent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          Text(
            "$amount L",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 6),
          Text(
            percent,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
