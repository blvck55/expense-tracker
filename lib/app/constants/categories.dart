import 'package:flutter/material.dart';

/// Represents metadata for an expense category including UI presentation assets.
class ExpenseCategory {
  final String name;
  final IconData icon;
  final Color color;

  const ExpenseCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

/// Category constants and helper methods for the Expense Tracker app.
class AppCategories {
  static const String food = 'Food';
  static const String transport = 'Transport';
  static const String shopping = 'Shopping';
  static const String bills = 'Bills';
  static const String entertainment = 'Entertainment';
  static const String health = 'Health';
  static const String other = 'Other';

  static const List<String> categories = [
    food,
    transport,
    shopping,
    bills,
    entertainment,
    health,
    other,
  ];

  static final Map<String, ExpenseCategory> categoryDetails = {
    food: const ExpenseCategory(
      name: food,
      icon: Icons.fastfood_rounded,
      color: Colors.orangeAccent,
    ),
    transport: const ExpenseCategory(
      name: transport,
      icon: Icons.directions_bus_rounded,
      color: Colors.blueAccent,
    ),
    shopping: const ExpenseCategory(
      name: shopping,
      icon: Icons.shopping_bag_rounded,
      color: Colors.purpleAccent,
    ),
    bills: const ExpenseCategory(
      name: bills,
      icon: Icons.receipt_long_rounded,
      color: Colors.redAccent,
    ),
    entertainment: const ExpenseCategory(
      name: entertainment,
      icon: Icons.movie_rounded,
      color: Colors.teal,
    ),
    health: const ExpenseCategory(
      name: health,
      icon: Icons.medical_services_rounded,
      color: Colors.green,
    ),
    other: const ExpenseCategory(
      name: other,
      icon: Icons.category_rounded,
      color: Colors.blueGrey,
    ),
  };

  /// Returns the corresponding [IconData] for a category name.
  static IconData getIcon(String category) {
    return categoryDetails[category]?.icon ?? Icons.category_rounded;
  }

  /// Returns the corresponding [Color] for a category name.
  static Color getColor(String category) {
    return categoryDetails[category]?.color ?? Colors.blueGrey;
  }
}
