import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/transaction_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expense.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL,
            category TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertTransaction(TransactionModel tx) async {
    final database = await db;
    return await database.insert('transactions', tx.toMap());
  }

  Future<List<TransactionModel>> getTransactions() async {
    final database = await db;
    final List<Map<String, dynamic>> maps = await database.query(
      'transactions',
    );
    return List.generate(maps.length, (i) => TransactionModel.fromMap(maps[i]));
  }

  Future<int> deleteTransaction(int id) async {
    final database = await db;
    return await database.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
