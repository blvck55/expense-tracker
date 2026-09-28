import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Representation of a supported currency option.
class AppCurrency {
  final String code;
  final String symbol;
  final String name;
  final int decimalDigits;

  const AppCurrency({
    required this.code,
    required this.symbol,
    required this.name,
    this.decimalDigits = 2,
  });
}

/// Provider managing active currency selection across the entire app.
class CurrencyProvider extends ChangeNotifier {
  static const List<AppCurrency> currencies = [
    AppCurrency(code: 'USD', symbol: '\$', name: 'US Dollar (\$)'),
    AppCurrency(code: 'LKR', symbol: 'Rs. ', name: 'Sri Lankan Rupee (LKR)'),
    AppCurrency(code: 'INR', symbol: '₹', name: 'Indian Rupee (₹)'),
    AppCurrency(code: 'AUD', symbol: 'A\$', name: 'Australian Dollar (AUD)'),
    AppCurrency(code: 'EUR', symbol: '€', name: 'Euro (€)'),
    AppCurrency(code: 'GBP', symbol: '£', name: 'British Pound (£)'),
    AppCurrency(code: 'CAD', symbol: 'C\$', name: 'Canadian Dollar (CAD)'),
    AppCurrency(code: 'JPY', symbol: '¥', name: 'Japanese Yen (¥)', decimalDigits: 0),
    AppCurrency(code: 'SGD', symbol: 'S\$', name: 'Singapore Dollar (SGD)'),
    AppCurrency(code: 'AED', symbol: 'AED ', name: 'UAE Dirham (AED)'),
    AppCurrency(code: 'SAR', symbol: 'SAR ', name: 'Saudi Riyal (SAR)'),
    AppCurrency(code: 'NZD', symbol: 'NZ\$', name: 'New Zealand Dollar (NZD)'),
  ];

  AppCurrency _selectedCurrency = currencies.first;

  AppCurrency get selectedCurrency => _selectedCurrency;

  void setCurrency(AppCurrency currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  void setCurrencyByCode(String code) {
    final found = currencies.firstWhere(
      (c) => c.code.toUpperCase() == code.toUpperCase(),
      orElse: () => currencies.first,
    );
    setCurrency(found);
  }

  /// Formats double amount to string with active currency symbol & decimals.
  String format(double amount) {
    final formatter = NumberFormat.currency(
      symbol: _selectedCurrency.symbol,
      decimalDigits: _selectedCurrency.decimalDigits,
    );
    return formatter.format(amount);
  }
}
