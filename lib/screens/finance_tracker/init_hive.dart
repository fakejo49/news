import 'package:hive_flutter/hive_flutter.dart';
import 'expense_model.dart';

class HiveInit {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseModelAdapter());
    await Hive.openBox<ExpenseModel>('expenses');
  }
}
