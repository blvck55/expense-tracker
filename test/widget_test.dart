import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/models/expense_model.dart';
import 'package:expensetracker/providers/expense_provider.dart';

void main() {
  group('Expense Tracker Tests', () {
    test('ExpenseModel copyWith updates fields correctly', () {
      final now = DateTime.now();
      final expense = ExpenseModel(
        id: '1',
        userId: 'user1',
        title: 'Lunch',
        amount: 15.50,
        category: 'Food',
        date: now,
        note: 'Burger and drink',
      );

      final updated = expense.copyWith(
        amount: 20.00,
        note: 'Updated burger order',
      );

      expect(updated.id, '1');
      expect(updated.title, 'Lunch');
      expect(updated.amount, 20.00);
      expect(updated.note, 'Updated burger order');
    });

    test('ExpenseProvider initial state and filter updates', () {
      final provider = ExpenseProvider();

      expect(provider.searchQuery, '');
      expect(provider.selectedCategory, null);
      expect(provider.isLoading, false);

      provider.setSearchQuery('Groceries');
      expect(provider.searchQuery, 'Groceries');

      provider.setSelectedCategory('Food');
      expect(provider.selectedCategory, 'Food');

      provider.clearFilters();
      expect(provider.searchQuery, '');
      expect(provider.selectedCategory, null);
    });
  });
}
