import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';
import '../screens/add_transaction_screen.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel tx;
  const TransactionItem({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(tx.title),
        subtitle: Text(
          "${tx.category} - ${tx.date.day}/${tx.date.month}/${tx.date.year}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddTransactionScreen(transaction: tx),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Xác nhận xóa'),
                    content: const Text(
                      'Bạn có chắc chắn muốn xóa giao dịch này?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Xóa'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  Provider.of<TransactionProvider>(
                    context,
                    listen: false,
                  ).deleteTransaction(tx.id!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
