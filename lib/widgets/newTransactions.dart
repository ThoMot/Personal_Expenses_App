import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();




  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmt = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmt <=0){
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmt);

    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "Save Transaction",
                    style: TextStyle(color: Colors.purple),
                  ),
                  onPressed: submitData,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
