import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTrans;
  Chart(this.recentTrans);

  List <Map<String, Object>> get Bars{
      return List.generate(7, (index) {
        final weekday = DateTime.now().subtract(Duration(days: index));
        double total; 
        for(int i; i < recentTrans.length; i++){
          if(recentTrans[i].time.day == weekday.day && recentTrans[i].time.month == weekday.month && recentTrans[i].time.year == weekday.year){
            total += recentTrans[i].amount;
          }
        }

        return {"day": DateFormat.E().format(weekday), "amt": total};
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(children: <Widget>[

      ],),
    );
  }
}
