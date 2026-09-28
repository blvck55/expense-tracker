import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../app/constants/categories.dart';
import '../../providers/auth_provider.dart';
import '../../providers/expense_provider.dart';
import '../../providers/theme_provider.dart';
import '../expense/add_edit_expense_dialog.dart';
import '../settings/settings_profile_screen.dart';
import '../stats/stats_screen.dart';
import '../widgets/empty_state.dart';
import '../widgets/expense_card.dart';
import '../widgets/summary_card.dart';

/// Main Home screen displaying monthly summary, search & filters, expense list history, FAB.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.user != null) {
        Provider.of<ExpenseProvider>(context, listen: false)
            .initExpensesStream(authProvider.user!.uid);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    final initialRange = expenseProvider.selectedDateRange ??
        DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 30)),
          end: DateTime.now(),
        );

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: initialRange,
    );

    if (picked != null) {
      expenseProvider.setDateRange(picked);
    }
  }

  void _openAddExpenseModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: const BoxConstraints(maxWidth: 600),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => const AddEditExpenseDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    final filteredExpenses = expenseProvider.filteredExpenses;
    final hasActiveFilters = expenseProvider.searchQuery.isNotEmpty ||
        expenseProvider.selectedCategory != null ||
        expenseProvider.selectedDateRange != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          // Theme Toggle
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: 'Toggle Theme',
            onPressed: () {
              themeProvider.toggleTheme(!themeProvider.isDarkMode);
            },
          ),
          // Analytics / Stats
          IconButton(
            icon: const Icon(Icons.pie_chart),
            tooltip: 'Analytics',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const StatsScreen()),
              );
            },
          ),
          // Settings & Profile
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings & Profile',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                // Monthly Summary Card
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: SummaryCard(),
                ),

                // Search Bar & Filter Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Column(
                    children: [
                      // Search TextField
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search expenses by title or note...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    expenseProvider.setSearchQuery('');
                                  },
                                )
                              : null,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (val) {
                          expenseProvider.setSearchQuery(val);
                        },
                      ),
                      const SizedBox(height: 8),

                      // Filter Row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Category Dropdown Filter
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).dividerColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String?>(
                                  value: expenseProvider.selectedCategory,
                                  hint: const Text('Category'),
                                  isDense: true,
                                  items: [
                                    const DropdownMenuItem<String?>(
                                      value: null,
                                      child: Text('All Categories'),
                                    ),
                                    ...AppCategories.categories.map((cat) {
                                      return DropdownMenuItem<String?>(
                                        value: cat,
                                        child: Row(
                                          children: [
                                            Icon(
                                              AppCategories.getIcon(cat),
                                              size: 16,
                                              color: AppCategories.getColor(cat),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(cat),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                  onChanged: (val) {
                                    expenseProvider.setSelectedCategory(val);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Date Range Filter Chip
                            ActionChip(
                              avatar: Icon(
                                Icons.date_range,
                                size: 18,
                                color: expenseProvider.selectedDateRange != null
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                              ),
                              label: Text(
                                expenseProvider.selectedDateRange != null
                                    ? '${DateFormat('MMM dd').format(expenseProvider.selectedDateRange!.start)} - ${DateFormat('MMM dd').format(expenseProvider.selectedDateRange!.end)}'
                                    : 'Date Range',
                              ),
                              onPressed: () => _selectDateRange(context),
                            ),

                            // Clear Filters Button (If Any Active)
                            if (hasActiveFilters) ...[
                              const SizedBox(width: 8),
                              ActionChip(
                                avatar: const Icon(Icons.filter_alt_off, size: 18, color: Colors.redAccent),
                                label: const Text(
                                  'Clear Filters',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
                                onPressed: () {
                                  _searchController.clear();
                                  expenseProvider.clearFilters();
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Expense History List Section
                Expanded(
                  child: expenseProvider.isLoading
                      ? Center(
                          child: SpinKitFadingCircle(
                            color: Theme.of(context).colorScheme.primary,
                            size: 50.0,
                          ),
                        )
                      : filteredExpenses.isEmpty
                          ? EmptyStateWidget(
                              title: hasActiveFilters ? 'No Matching Expenses' : 'No Expenses Recorded',
                              message: hasActiveFilters
                                  ? 'Try adjusting your search query or filter settings.'
                                  : 'Tap the button below to add your first expense.',
                              onActionPressed: () => _openAddExpenseModal(context),
                              actionLabel: 'Add Expense',
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                if (authProvider.user != null) {
                                  expenseProvider.initExpensesStream(authProvider.user!.uid);
                                }
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 80),
                                itemCount: filteredExpenses.length,
                                itemBuilder: (context, index) {
                                  final expense = filteredExpenses[index];
                                  return ExpenseCard(expense: expense);
                                },
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddExpenseModal(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Expense'),
      ),
    );
  }
}
