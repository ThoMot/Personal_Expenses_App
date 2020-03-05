import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/newTransactions.dart';
import 'package:personal_expenses_app/widgets/teansactionList.dart';

import './widgets/teansactionList.dart';
import './widgets/newTransactions.dart';
import './models/transaction.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      title: "Personal expenses",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.amber,
        fontFamily: "OpenSans",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: "t1", title: "New Shoes", amount: 69.99, time: DateTime.now()),
    // Transaction(
    //     id: "t2", title: "Groceries", amount: 16.53, time: DateTime.now()),
    // Transaction(id: "t3", title: "Coffee", amount: 05.50, time: DateTime.now()),
  ];

  List<Transaction> get _recentTrans {
    return _userTransactions.where((tx) {
      return tx.time.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = new Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        time: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
    
  }

  void startAddNewTx(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
            onTap: () {}, 
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal expenses"), actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => startAddNewTx(context),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTrans),
            TransactionList(_userTransactions, deleteTransaction)
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => startAddNewTx(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
