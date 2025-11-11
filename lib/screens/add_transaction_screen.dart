import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  final TransactionModel? transaction;

  const AddTransactionScreen({super.key, this.transaction});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  String _category = "Ăn uống";

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.transaction?.title ?? '',
    );
    _amountController = TextEditingController(
      text: widget.transaction?.amount?.toString() ?? '',
    );
    _category = widget.transaction?.category ?? 'Ăn uống';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        title: Text(
          isEditing ? '✏️ Sửa giao dịch' : '➕ Thêm giao dịch',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả',
                        prefixIcon: const Icon(Icons.description),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Không được bỏ trống' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Số tiền',
                        prefixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (v) => double.tryParse(v ?? '') == null
                          ? 'Phải nhập số hợp lệ'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _category,
                      decoration: InputDecoration(
                        labelText: 'Danh mục',
                        prefixIcon: const Icon(Icons.category),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          ['Ăn uống', 'Mua sắm', 'Giải trí', 'Hóa đơn', 'Khác']
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                      onChanged: (value) => setState(() => _category = value!),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(isEditing ? Icons.save : Icons.add),
                      label: Text(
                        isEditing ? 'Cập nhật giao dịch' : 'Lưu giao dịch',
                        style: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final tx = TransactionModel(
                            id: widget.transaction?.id,
                            title: _titleController.text,
                            amount: double.parse(_amountController.text),
                            category: _category,
                            date: DateTime.now(),
                          );

                          final provider = Provider.of<TransactionProvider>(
                            context,
                            listen: false,
                          );

                          if (isEditing) {
                            await provider.updateTransaction(tx);
                          } else {
                            await provider.addTransaction(tx);
                          }

                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
