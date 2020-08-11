import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {

  final List<Transaction> lastSevenDaysTranscations;

  Chart(this.lastSevenDaysTranscations);
  
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index){
        final weekDay = DateTime.now().subtract(Duration(days:index));
        var totalSum = 0.0;

        for( var i=0; i<lastSevenDaysTranscations.length; i++){
          
          if(lastSevenDaysTranscations[i].date.day == weekDay.day && 
          lastSevenDaysTranscations[i].date.month == weekDay.month &&
          lastSevenDaysTranscations[i].date.year == weekDay.year) {
            
            totalSum+= lastSevenDaysTranscations[i].amount;

          }
        }
        
        print(DateFormat.E().format(weekDay));
        print(totalSum);

        return {
          'day': DateFormat.E().format(weekDay).substring(0,1),
          'amount': totalSum,
        };
      },
    ).reversed.toList();
  }
  

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item){
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Padding(
      padding: const EdgeInsets.all(10),

      child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(20),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: groupedTransactionValues.map((data){
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'], 
                  data['amount'], 
                  totalSpending ==0.0 ? 0.0 : (data['amount'] as double) / totalSpending, 
                  ));
            }).toList(),
          ),

        ),
    );
  }
}