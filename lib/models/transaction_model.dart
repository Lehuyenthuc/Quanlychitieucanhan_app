class TransactionModel {
  final int? id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  TransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  // Convert to Map (lưu vào SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  // Convert từ Map ra model
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
    );
  }
}
