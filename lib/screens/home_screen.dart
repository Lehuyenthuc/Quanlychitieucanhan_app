import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_item.dart';
import 'add_transaction_screen.dart';
import '../widgets/expense_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final transactions = provider.transactions;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB), // Nền sáng tinh tế
      appBar: AppBar(
        title: const Text(
          '💰 Quản lý Chi tiêu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.teal.shade700,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Vùng biểu đồ — trong thẻ Card bo góc + bóng đổ nhẹ
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                shadowColor: Colors.teal.withOpacity(0.2),
                child: const SizedBox(
                  height: 250, // Cố định chiều cao để không bị che
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: ExpenseChart(),
                  ),
                ),
              ),
            ),

            // 🔹 Tiêu đề danh sách giao dịch
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4,
              ),
              child: Row(
                children: [
                  const Icon(Icons.history, color: Colors.teal),
                  const SizedBox(width: 8),
                  Text(
                    'Lịch sử chi tiêu',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Danh sách giao dịch
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: transactions.isEmpty
                    ? const Center(
                        child: Text(
                          'Chưa có giao dịch nào 😅',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.separated(
                        itemCount: transactions.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, thickness: 0.6),
                        itemBuilder: (context, i) {
                          return TransactionItem(tx: transactions[i]);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),

      // 🔹 Nút thêm giao dịch trông nổi bật hơn
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );
        },
        backgroundColor: Colors.teal.shade600,
        icon: const Icon(Icons.add),
        label: const Text('Thêm giao dịch'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
