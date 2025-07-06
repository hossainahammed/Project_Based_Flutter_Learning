import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Expense_modal.dart';

class ExpensePieChart extends StatelessWidget {
  final List<Expense> expenses;
  final String currency;

  const ExpensePieChart(
      {super.key, required this.expenses, required this.currency});

  @override
  Widget build(BuildContext context) {
    // Calculate total sum of all expenses
    final double total = expenses.fold(
        0.0, (sum, expense) => sum + expense.amount);

    final Map<String, double> dataMap = {};
    for (var expense in expenses) {
      dataMap.update(expense.category, (value) => value + expense.amount,
          ifAbsent: () => expense.amount);
    }

    final List<PieChartSectionData> sections = dataMap.entries.map((entry) {
      final double value = entry.value;
      final String category = entry.key;
      final Color color = _getCategoryColor(category);
      // Calculate percentage for the category
      final double percentage = total == 0 ? 0 : (value / total) * 100;
      return PieChartSectionData(
        color: color,
        value: value,
        // Show value as percentage with one decimal place and % sign
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    List<Widget> legendWidgets = dataMap.entries.map((entry) {
      final String category = entry.key;
      final Color color = _getCategoryColor(category);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: color,
              ),
            ),
            SizedBox(width: 6),
            // Wrap text to handle overflow
            Expanded(
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 12, // Reduced font size
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis, // Handle overflow
                maxLines: 1, // Limit to one line
              ),
            ),
          ],
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pie chart on the left
        Expanded(
          child: PieChart(
            PieChartData(
              sections: sections,
              sectionsSpace: 2,
              centerSpaceRadius: 30,
            ),
          ),
        ),
        // Legend on the right
        Container(
          width: 100,
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: legendWidgets,
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Color(0xFFFF9800); // Bright Orange - appetizing and friendly
      case 'Transport':
        return Color(0xFF2196F3); // Blue - calm and reliable
      case 'Entertainment':
        return Color(0xFF9C27B0); // Purple - fun and energetic
      case 'Bills':
        return Color(0xFFFF5722); // Deep Orange - serious but warm
      case 'Shopping':
        return Color(0xFFE91E63); // Pink - trendy and eye-catching
      case 'Hospital':
        return Color(0xFFC62828); // Dark Red - urgency/alert
      case 'Medichine': // Consider fixing typo to 'Medicine'
        return Color(0xFF009688); // Teal - calming, health-associated
      default:
        return Colors.grey; // Fallback color
    }
  }
}

//   Color _getCategoryColor(String category) {
//     switch (category) {
//       case 'Food':
//         return Colors.redAccent;
//       case 'Transport':
//         return Colors.blueAccent;
//       case 'Entertainment':
//         return Colors.green;
//       case 'Bills':
//         return Colors.orange;
//       case 'Shopping':
//         return Colors.pinkAccent;
//       case 'Hospital':
//         return Colors.red;
//       case 'Medichine':
//         return Colors.lightBlue;
//       default:
//         return Colors.grey;
//     }
//   }
// }