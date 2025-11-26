import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'expense_model.dart';
import 'hive_boxes.dart';
import 'add_expense.dart';
import 'edit_expense.dart';

class FinanceHome extends StatelessWidget {
  const FinanceHome({super.key});

  double getTotal(Box<ExpenseModel> box) {
    double total = 0;

    for (var item in box.values) {
      if (item.isIncome) {
        total += item.amount;
      } else {
        total -= item.amount;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("Finance Tracker"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddExpense()),
          );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveBoxes.getExpenses().listenable(),
        builder: (context, Box<ExpenseModel> box, _) {
          double total = getTotal(box);

          return Column(
            children: [
              // 🔥 HEADER PROFIL + TOTAL DANA
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          AssetImage('assets/default_cover.jpg'), // opsional
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "FakeJo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Rp ${total.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 🔥 LIST PEMASUKAN / PENGELUARAN
              Expanded(
                child: box.values.isEmpty
                    ? const Center(
                        child: Text(
                          "Belum ada data",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          final item = box.getAt(index)!;

                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade800.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.purpleAccent,
                                width: 1.2,
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                item.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                "${item.isIncome ? '+' : '-'} Rp ${item.amount} • ${item.date.toLocal()}".split(".")[0],
                                style:
                                    const TextStyle(color: Colors.white70),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.greenAccent),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EditExpense(
                                            index: index,
                                            expense: item,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      box.deleteAt(index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}
