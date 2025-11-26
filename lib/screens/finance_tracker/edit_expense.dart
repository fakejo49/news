import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'expense_model.dart';
import 'hive_boxes.dart';

class EditExpense extends StatefulWidget {
  final int index;
  final ExpenseModel expense;

  const EditExpense({
    super.key,
    required this.index,
    required this.expense,
  });

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  late TextEditingController titleC;
  late TextEditingController amountC;

  late bool isIncome;

  @override
  void initState() {
    super.initState();

    titleC = TextEditingController(text: widget.expense.title);
    amountC = TextEditingController(text: widget.expense.amount.toString());
    isIncome = widget.expense.isIncome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Edit Data Keuangan"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // INPUT JUDUL
            TextField(
              controller: titleC,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Judul",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),

            // INPUT JUMLAH
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

            // SWITCH PEMASUKAN
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

            const SizedBox(height: 25),

            // TOMBOL SIMPAN
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
              ),
              onPressed: () {
                final updatedItem = ExpenseModel(
                  title: titleC.text,
                  amount: double.parse(amountC.text),
                  date: widget.expense.date,
                  isIncome: isIncome,
                );

                // UPDATE ITEM DI HIVE
                HiveBoxes.getExpenses().putAt(widget.index, updatedItem);

                Navigator.pop(context);
              },
              child: const Text("Simpan Perubahan"),
            )
          ],
        ),
      ),
    );
  }
}
