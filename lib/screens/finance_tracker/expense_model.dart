import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  bool isIncome; // ✔ ini yang benar

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}
