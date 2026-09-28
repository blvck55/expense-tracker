import 'package:cloud_firestore/cloud_firestore.dart';

/// Data model representing an expense item.
class ExpenseModel {
  final String id;
  final String userId;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String? note;
  final String? imageUrl;
  final DateTime? createdAt;

  ExpenseModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
    this.imageUrl,
    this.createdAt,
  });

  /// Converts the [ExpenseModel] instance into a JSON-compatible Map for Firestore.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'amount': amount,
      'category': category,
      'date': Timestamp.fromDate(date),
      'note': note ?? '',
      'imageUrl': imageUrl ?? '',
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  /// Creates an [ExpenseModel] from a Firestore DocumentSnapshot.
  factory ExpenseModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    DateTime parseDateTime(dynamic field) {
      if (field is Timestamp) {
        return field.toDate();
      } else if (field is String) {
        return DateTime.tryParse(field) ?? DateTime.now();
      } else if (field is int) {
        return DateTime.fromMillisecondsSinceEpoch(field);
      }
      return DateTime.now();
    }

    final img = data['imageUrl'] as String?;

    return ExpenseModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      title: data['title'] as String? ?? '',
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
      category: data['category'] as String? ?? 'Other',
      date: parseDateTime(data['date']),
      note: data['note'] as String?,
      imageUrl: (img != null && img.isNotEmpty) ? img : null,
      createdAt: data['createdAt'] != null ? parseDateTime(data['createdAt']) : null,
    );
  }

  /// Copies existing [ExpenseModel] with modified properties.
  ExpenseModel copyWith({
    String? id,
    String? userId,
    String? title,
    double? amount,
    String? category,
    DateTime? date,
    String? note,
    String? imageUrl,
    bool clearImage = false,
    DateTime? createdAt,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
      imageUrl: clearImage ? null : (imageUrl ?? this.imageUrl),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
