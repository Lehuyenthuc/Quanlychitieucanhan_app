// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/transaction_provider.dart';
// import 'screens/home_screen.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => TransactionProvider()..loadTransactions(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Quản lý Chi tiêu',
//       theme: ThemeData(primarySwatch: Colors.teal),
//       home: const HomeScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';
import 'screens/home_screen.dart';

// 👇 import cho sqflite_common_ffi
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // 👇 Khởi tạo SQLite cho Desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(
    ChangeNotifierProvider(
      create: (_) => TransactionProvider()..loadTransactions(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý Chi tiêu',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
    );
  }
}
