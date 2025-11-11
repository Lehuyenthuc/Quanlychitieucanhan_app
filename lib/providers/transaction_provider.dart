import 'package:flutter/foundation.dart';
import '../db/database_helper.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  // 🟢 Tải toàn bộ giao dịch
  Future<void> loadTransactions() async {
    _transactions = await _dbHelper.getTransactions();
    notifyListeners();
  }

  // 🟢 Thêm giao dịch mới
  Future<void> addTransaction(TransactionModel tx) async {
    await _dbHelper.insertTransaction(tx);
    await loadTransactions();
  }

  // 🟢 Cập nhật giao dịch (sửa thông tin)
  Future<void> updateTransaction(TransactionModel tx) async {
    final dbClient = await _dbHelper.db;
    await dbClient.update(
      'transactions',
      tx.toMap(),
      where: 'id = ?',
      whereArgs: [tx.id],
    );
    await loadTransactions();
  }

  // 🟢 Xóa giao dịch theo id
  Future<void> deleteTransaction(int id) async {
    await _dbHelper.deleteTransaction(id);
    await loadTransactions();
  }
}
