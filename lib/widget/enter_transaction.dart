import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnterTransaction extends StatefulWidget {
  final Function addTransactionHandler;

  EnterTransaction(this.addTransactionHandler);

  @override
  _EnterTransactionState createState() => _EnterTransactionState();
}

class _EnterTransactionState extends State<EnterTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _dateOfTransaction;

  void _onSubmitTransaction() {
    final transactionTitle = titleController.text;
    final transactionAmount = double.parse(amountController.text, (_) => 0);

    if (transactionTitle.isEmpty ||
        transactionAmount <= 0 ||
        _dateOfTransaction == null) return;

    widget.addTransactionHandler(
        transactionTitle, transactionAmount, _dateOfTransaction);

    Navigator.of(context).pop();
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _dateOfTransaction = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _onSubmitTransaction(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(children: [
                  _dateOfTransaction != null
                      ? Text(
                          DateFormat.yMMMd().format(_dateOfTransaction),
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      : Text(
                          "No date selected",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: FlatButton(
                      onPressed: () {
                        _selectDate();
                      },
                      child: Text("Change Date",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  )
                ]),
              ),
              RaisedButton(
                  onPressed: _onSubmitTransaction,
                  highlightColor: Colors.purpleAccent,
                  child: Text(
                    "Add Transaction",
                    style: Theme.of(context).textTheme.button,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
