import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../app/constants/categories.dart';
import '../../providers/currency_provider.dart';
import '../../providers/expense_provider.dart';
import '../widgets/empty_state.dart';

/// Screen displaying interactive category breakdown charts using fl_chart.
class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final selectedMonth = expenseProvider.selectedMonth;
    final categoryTotals = expenseProvider.currentMonthCategoryTotals;
    final totalMonthAmount = expenseProvider.currentMonthTotal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Analytics'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Month Selector Card
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () {
                              expenseProvider.setSelectedMonth(
                                DateTime(selectedMonth.year, selectedMonth.month - 1, 1),
                              );
                            },
                          ),
                          Text(
                            DateFormat('MMMM yyyy').format(selectedMonth),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {
                              expenseProvider.setSelectedMonth(
                                DateTime(selectedMonth.year, selectedMonth.month + 1, 1),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (categoryTotals.isEmpty || totalMonthAmount <= 0)
                    const SizedBox(
                      height: 400,
                      child: EmptyStateWidget(
                        title: 'No Data for Selected Month',
                        message: 'Add expenses in this month to see dynamic chart analytics.',
                        icon: Icons.pie_chart_outline_rounded,
                      ),
                    )
                  else
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 700;

                        final pieChartCard = Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Category Breakdown',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Total: ${currencyProvider.format(totalMonthAmount)}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  height: 220,
                                  child: PieChart(
                                    PieChartData(
                                      pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                          setState(() {
                                            if (!event.isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse.touchedSection == null) {
                                              _touchedIndex = -1;
                                              return;
                                            }
                                            _touchedIndex =
                                                pieTouchResponse.touchedSection!.touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      borderData: FlBorderData(show: false),
                                      sectionsSpace: 3,
                                      centerSpaceRadius: 40,
                                      sections: _generatePieSections(categoryTotals, totalMonthAmount),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                        final detailsCard = Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Category Details',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: categoryTotals.length,
                                  separatorBuilder: (_, __) => const Divider(height: 1),
                                  itemBuilder: (context, index) {
                                    final category = categoryTotals.keys.elementAt(index);
                                    final amount = categoryTotals[category]!;
                                    final percentage = (amount / totalMonthAmount) * 100;
                                    final color = AppCategories.getColor(category);
                                    final icon = AppCategories.getIcon(category);

                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(icon, color: color, size: 20),
                                      ),
                                      title: Text(
                                        category,
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: LinearProgressIndicator(
                                        value: percentage / 100,
                                        backgroundColor: color.withValues(alpha: 0.1),
                                        color: color,
                                        minHeight: 6,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            currencyProvider.format(amount),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            '${percentage.toStringAsFixed(1)}%',
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.bodySmall?.color,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );

                        if (isWide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 4, child: pieChartCard),
                              const SizedBox(width: 16),
                              Expanded(flex: 6, child: detailsCard),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              pieChartCard,
                              const SizedBox(height: 20),
                              detailsCard,
                            ],
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generatePieSections(
      Map<String, double> categoryTotals, double total) {
    final categories = categoryTotals.keys.toList();
    return List.generate(categories.length, (i) {
      final isTouched = i == _touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? 65.0 : 55.0;
      final category = categories[i];
      final amount = categoryTotals[category]!;
      final percentage = total > 0 ? (amount / total * 100) : 0.0;
      final color = AppCategories.getColor(category);

      return PieChartSectionData(
        color: color,
        value: amount,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }
}
