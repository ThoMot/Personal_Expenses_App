import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTrans;
  Chart(this.recentTrans);

  List<Map<String, Object>> get Bars {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double total = 0;
      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].time.day == weekday.day &&
            recentTrans[i].time.month == weekday.month &&
            recentTrans[i].time.year == weekday.year) {
          total += recentTrans[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekday).substring(0, 1),
        "amt": total
      };
    });
  }

  double get maxSpending {
    return Bars.fold(0.0, (sum, item) {
      return sum + item['amt'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: Bars.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    data['day'],
                    data['amt'],
                    maxSpending == 0.0
                        ? 0.0
                        : (data['amt'] as double) / maxSpending,
                  ),
                );
              }).toList()),
        ));
  }
}
