import 'dart:async';
import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../services/firestore_service.dart';

/// State management provider for Expense list, filters, summary calculations, and CRUD ops.
class ExpenseProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<ExpenseModel> _expenses = [];
  StreamSubscription<List<ExpenseModel>>? _subscription;
  bool _isLoading = false;
  String? _errorMessage;

  // Filter state variables
  String _searchQuery = '';
  String? _selectedCategory;
  DateTimeRange? _selectedDateRange;
  DateTime _selectedMonth = DateTime.now();

  // Getters
  List<ExpenseModel> get expenses => _expenses;
  List<ExpenseModel> get allExpenses => _expenses;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  DateTimeRange? get selectedDateRange => _selectedDateRange;
  DateTime get selectedMonth => _selectedMonth;

  /// Returns the filtered list of expenses based on search query, category, and date range.
  List<ExpenseModel> get filteredExpenses {
    return _expenses.where((expense) {
      // 1. Search Query Filter (Title or Note)
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final titleMatches = expense.title.toLowerCase().contains(query);
        final noteMatches = expense.note?.toLowerCase().contains(query) ?? false;
        if (!titleMatches && !noteMatches) return false;
      }

      // 2. Category Filter
      if (_selectedCategory != null &&
          _selectedCategory != 'All' &&
          _selectedCategory!.isNotEmpty) {
        if (expense.category != _selectedCategory) return false;
      }

      // 3. Custom Date Range Filter
      if (_selectedDateRange != null) {
        final expenseDate = DateTime(expense.date.year, expense.date.month, expense.date.day);
        final startDate = DateTime(
          _selectedDateRange!.start.year,
          _selectedDateRange!.start.month,
          _selectedDateRange!.start.day,
        );
        final endDate = DateTime(
          _selectedDateRange!.end.year,
          _selectedDateRange!.end.month,
          _selectedDateRange!.end.day,
          23,
          59,
          59,
        );

        if (expenseDate.isBefore(startDate) || expenseDate.isAfter(endDate)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  /// Total sum for expenses in the currently selected month.
  double get currentMonthTotal {
    return _expenses.where((expense) {
      return expense.date.year == _selectedMonth.year &&
          expense.date.month == _selectedMonth.month;
    }).fold(0.0, (sum, item) => sum + item.amount);
  }

  /// Total sum of all currently filtered expenses.
  double get totalFilteredAmount {
    return filteredExpenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  /// Calculates category breakdown totals for the selected month (for chart visualization).
  Map<String, double> get currentMonthCategoryTotals {
    final Map<String, double> totals = {};
    final monthExpenses = _expenses.where((expense) {
      return expense.date.year == _selectedMonth.year &&
          expense.date.month == _selectedMonth.month;
    });

    for (var expense in monthExpenses) {
      totals[expense.category] = (totals[expense.category] ?? 0.0) + expense.amount;
    }
    return totals;
  }

  /// Subscribes to real-time Firestore stream for given user ID.
  void initExpensesStream(String userId) {
    _isLoading = true;
    notifyListeners();

    _subscription?.cancel();
    _subscription = _firestoreService.streamExpenses(userId).listen(
      (data) {
        _expenses = data;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        _isLoading = false;
        _errorMessage = 'Failed to load expenses: ${error.toString()}';
        notifyListeners();
      },
    );
  }

  /// Set Search Query keyword
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Set Selected Category filter ('All' or specific category name)
  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// Set Selected Date Range filter
  void setDateRange(DateTimeRange? range) {
    _selectedDateRange = range;
    notifyListeners();
  }

  /// Set Selected Month for Monthly Summary and Stats
  void setSelectedMonth(DateTime month) {
    _selectedMonth = month;
    notifyListeners();
  }

  /// Clear all active filters
  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _selectedDateRange = null;
    notifyListeners();
  }

  /// Clear error state
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // --- CRUD OPERATIONS ---

  /// Adds a new expense item to Firestore
  Future<bool> addExpense(ExpenseModel expense) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firestoreService.addExpense(expense);
      _isLoading = false;
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to add expense: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  /// Updates an existing expense item in Firestore
  Future<bool> updateExpense(ExpenseModel expense) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firestoreService.updateExpense(expense);
      _isLoading = false;
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to update expense: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  /// Deletes an expense item by ID
  Future<bool> deleteExpense(String expenseId) async {
    try {
      await _firestoreService.deleteExpense(expenseId);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete expense: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
