import 'package:flutter/material.dart';

import '../model/transaction.dart';
import '../widget/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransactionHandler;

  TransactionList(this._transactions, this._deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return TransactionItem(
            transaction: _transactions[index],
            deleteTransactionHandler: _deleteTransactionHandler);
      },
      itemCount: _transactions.length,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}
