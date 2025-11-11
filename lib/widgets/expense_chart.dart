// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:provider/provider.dart';
// // import '../providers/transaction_provider.dart';

// // class ExpenseChart extends StatelessWidget {
// //   const ExpenseChart({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final transactions = Provider.of<TransactionProvider>(context).transactions;

// //     Map<String, double> totals = {};
// //     for (var tx in transactions) {
// //       totals[tx.category] = (totals[tx.category] ?? 0) + tx.amount;
// //     }

// //     final items = totals.entries.toList();

// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: BarChart(
// //         BarChartData(
// //           titlesData: FlTitlesData(show: true),
// //           borderData: FlBorderData(show: false),
// //           barGroups: items.map((e) {
// //             return BarChartGroupData(
// //               x: items.indexOf(e),
// //               barRods: [BarChartRodData(toY: e.value, width: 20)],
// //               showingTooltipIndicators: [0],
// //             );
// //           }).toList(),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:provider/provider.dart';
// import '../providers/transaction_provider.dart';

// class ExpenseChart extends StatefulWidget {
//   const ExpenseChart({super.key});

//   @override
//   State<ExpenseChart> createState() => _ExpenseChartState();
// }

// class _ExpenseChartState extends State<ExpenseChart> {
//   String _selectedChart = 'Bar'; // mặc định hiển thị biểu đồ cột

//   @override
//   Widget build(BuildContext context) {
//     final transactions = Provider.of<TransactionProvider>(context).transactions;

//     // Gom dữ liệu theo danh mục
//     Map<String, double> totals = {};
//     for (var tx in transactions) {
//       totals[tx.category] = (totals[tx.category] ?? 0) + tx.amount;
//     }
//     final items = totals.entries.toList();

//     return Column(
//       children: [
//         // 🔹 Thanh chọn loại biểu đồ
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Chọn loại biểu đồ:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(width: 10),
//               DropdownButton<String>(
//                 value: _selectedChart,
//                 items: const [
//                   DropdownMenuItem(value: 'Bar', child: Text('Biểu đồ Cột')),
//                   DropdownMenuItem(value: 'Pie', child: Text('Biểu đồ Tròn')),
//                   DropdownMenuItem(value: 'Line', child: Text('Biểu đồ Đường')),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedChart = value!;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),

//         // 🔹 Vùng hiển thị biểu đồ
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: _buildChart(items),
//           ),
//         ),
//       ],
//     );
//   }

//   /// 🔸 Hàm chọn biểu đồ dựa theo loại người dùng chọn
//   Widget _buildChart(List<MapEntry<String, double>> items) {
//     switch (_selectedChart) {
//       case 'Pie':
//         return PieChart(
//           PieChartData(
//             sections: items.map((e) {
//               final color =
//                   Colors.primaries[items.indexOf(e) % Colors.primaries.length];
//               return PieChartSectionData(
//                 color: color,
//                 value: e.value,
//                 title: e.key,
//                 radius: 60,
//                 titleStyle: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               );
//             }).toList(),
//             sectionsSpace: 2,
//             centerSpaceRadius: 40,
//           ),
//         );

//       case 'Line':
//         return LineChart(
//           LineChartData(
//             titlesData: FlTitlesData(show: true),
//             borderData: FlBorderData(show: true),
//             lineBarsData: [
//               LineChartBarData(
//                 spots: items
//                     .asMap()
//                     .entries
//                     .map((e) => FlSpot(e.key.toDouble(), e.value.value))
//                     .toList(),
//                 isCurved: true,
//                 color: Colors.blueAccent,
//                 dotData: const FlDotData(show: true),
//                 belowBarData: BarAreaData(
//                   show: true,
//                   color: Colors.blueAccent.withOpacity(0.3),
//                 ),
//               ),
//             ],
//           ),
//         );

//       default: // 'Bar'
//         return BarChart(
//           BarChartData(
//             titlesData: FlTitlesData(show: true),
//             borderData: FlBorderData(show: false),
//             barGroups: items.map((e) {
//               return BarChartGroupData(
//                 x: items.indexOf(e),
//                 barRods: [
//                   BarChartRodData(
//                     toY: e.value,
//                     width: 20,
//                     color: Colors.tealAccent.shade700,
//                   ),
//                 ],
//                 showingTooltipIndicators: [0],
//               );
//             }).toList(),
//           ),
//         );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({super.key});

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  String _chartType = 'Cột'; // Mặc định là biểu đồ cột

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;

    // Gom chi tiêu theo danh mục
    Map<String, double> totals = {};
    for (var tx in transactions) {
      totals[tx.category] = (totals[tx.category] ?? 0) + tx.amount;
    }
    final items = totals.entries.toList();

    // Tính tổng chi tiêu
    double total = transactions.fold(0, (sum, tx) => sum + tx.amount);

    // Nhận xét dựa vào tổng chi tiêu
    String feedback;
    if (total == 0) {
      feedback = "Hôm nay chưa có chi tiêu 💸";
    } else if (total < 100000) {
      feedback = "Chi tiêu rất tiết kiệm 👏";
    } else if (total < 500000) {
      feedback = "Chi tiêu hợp lý 👍";
    } else if (total < 1000000) {
      feedback = "Chi tiêu hơi cao, cân nhắc nhé 😅";
    } else {
      feedback = "Chi tiêu quá nhiều! Hãy kiểm soát lại 😱";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 🔹 Bộ chọn loại biểu đồ
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton<String>(
              value: _chartType,
              borderRadius: BorderRadius.circular(12),
              items: const [
                DropdownMenuItem(value: 'Cột', child: Text('📊 Biểu đồ Cột')),
                DropdownMenuItem(value: 'Tròn', child: Text('🥧 Biểu đồ Tròn')),
                DropdownMenuItem(
                  value: 'Đường',
                  child: Text('📈 Biểu đồ Đường'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _chartType = value!;
                });
              },
            ),
          ],
        ),

        const SizedBox(height: 10),

        // 🔹 Biểu đồ hiển thị theo lựa chọn
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text(
                    "Chưa có dữ liệu để vẽ biểu đồ 😅",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : _buildChart(items),
        ),

        // 🔹 Nhận xét chi tiêu
        const SizedBox(height: 10),
        Center(
          child: Text(
            feedback,
            style: TextStyle(
              fontSize: 16,
              color: _getFeedbackColor(total),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // --- Hàm chọn loại biểu đồ ---
  Widget _buildChart(List<MapEntry<String, double>> items) {
    switch (_chartType) {
      case 'Tròn':
        return PieChart(
          PieChartData(
            sections: items
                .map(
                  (e) => PieChartSectionData(
                    title: e.key,
                    value: e.value,
                    radius: 60,
                  ),
                )
                .toList(),
          ),
        );
      case 'Đường':
        return LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                spots: items
                    .asMap()
                    .entries
                    .map(
                      (e) => FlSpot(e.key.toDouble(), e.value.value.toDouble()),
                    )
                    .toList(),
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.teal.withOpacity(0.2),
                ),
              ),
            ],
          ),
        );
      default: // Cột
        return BarChart(
          BarChartData(
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            barGroups: items
                .asMap()
                .entries
                .map(
                  (e) => BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value.value,
                        width: 18,
                        color: Colors.teal.shade400,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        );
    }
  }

  // --- Hàm chọn màu nhận xét ---
  Color _getFeedbackColor(double total) {
    if (total == 0) return Colors.grey;
    if (total < 100000) return Colors.green;
    if (total < 500000) return Colors.blue;
    if (total < 1000000) return Colors.orange;
    return Colors.red;
  }
}
