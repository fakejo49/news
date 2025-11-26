import 'package:hive/hive.dart';
import 'expense_model.dart';

class HiveBoxes {
  static Box<ExpenseModel> getExpenses() =>
      Hive.box<ExpenseModel>('expenses');
}
