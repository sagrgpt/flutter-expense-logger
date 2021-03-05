import 'package:expense_app/widget/char_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final totalSum = _getTotalAmountFor(weekDay);

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum,
      };
    }).reversed.toList();
  }

  double get _totalSpending {
    return _groupedTransactionValues.fold(
        0.0, (sum, item) => sum += item['amount']);
  }

  double _getTotalAmountFor(DateTime date) {
    var totalSum = 0.0;
    for (Transaction trx in recentTransactions) {
      if (_isEqual(trx.date, date)) {
        totalSum += trx.amount;
      }
    }
    return totalSum;
  }

  bool _isEqual(DateTime transactionDate, DateTime weekDay) {
    return transactionDate.day == weekDay.day &&
        transactionDate.month == weekDay.month &&
        transactionDate.year == weekDay.year;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data["day"],
                data["amount"],
                _totalSpending == 0.0
                    ? 0.0
                    : (data["amount"] as double) / _totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
