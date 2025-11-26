import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'expense_model.dart';
import 'hive_boxes.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final titleC = TextEditingController();
  final amountC = TextEditingController();

  bool isIncome = false; // default: pengeluaran

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Tambah Data"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Judul",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),
            TextField(
              controller: amountC,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Jumlah",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),

            const SizedBox(height: 20),

            // SWITCH PEMASUKAN / PENGELUARAN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pemasukan?", style: TextStyle(color: Colors.white)),
                Switch(
                  value: isIncome,
                  onChanged: (v) => setState(() => isIncome = v),
                )
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () {
                final newItem = ExpenseModel(
                  title: titleC.text,
                  amount: double.parse(amountC.text),
                  date: DateTime.now(),
                  isIncome: isIncome,
                );

                HiveBoxes.getExpenses().add(newItem);
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
