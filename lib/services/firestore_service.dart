import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense_model.dart';

/// Database service handling Firestore CRUD operations for user expenses.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collection = 'expenses';

  /// Returns a real-time stream of expenses for a specific [userId].
  /// Expenses are sorted in descending chronological order (newest first).
  Stream<List<ExpenseModel>> streamExpenses(String userId) {
    return _db
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final expenses = snapshot.docs
          .map((doc) => ExpenseModel.fromFirestore(doc))
          .toList();
      // Sort in memory to guarantee ordering without requiring composite index creation
      expenses.sort((a, b) => b.date.compareTo(a.date));
      return expenses;
    });
  }

  /// Adds a new expense document to Cloud Firestore.
  Future<DocumentReference> addExpense(ExpenseModel expense) async {
    return await _db.collection(_collection).add(expense.toMap());
  }

  /// Updates an existing expense document in Cloud Firestore.
  Future<void> updateExpense(ExpenseModel expense) async {
    await _db.collection(_collection).doc(expense.id).update(expense.toMap());
  }

  /// Deletes an expense document from Cloud Firestore by [expenseId].
  Future<void> deleteExpense(String expenseId) async {
    await _db.collection(_collection).doc(expenseId).delete();
  }
}
