import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum MyCategory{ food , travel , leisure , work }

const categoryIcons = {
  MyCategory.food: Icons.lunch_dining,
  MyCategory.travel: Icons.flight_takeoff,
  MyCategory.leisure: Icons.movie,
  MyCategory.work: Icons.work,
};

class Expense{

  final String id;
  final String title;
  final double amount;
  final DateTime date; 
  final MyCategory category;


 Expense({ 
    required this.title,
    required this.amount, 
    required this.date,
    required this.category,
    }) : id = uuid.v4();


    String get formattedDate{
      return formatter.format(date);
    } 

}

class ExpenseBucket {
  const ExpenseBucket({
    required this.Acategory,
    required this.expenses,
  });

  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.Acategory) : expenses = allExpenses.where(
      (expense) => expense.category == Acategory
      ).toList();

  final MyCategory Acategory;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0;
    
    for(final expense in expenses){
      sum += expense.amount;
    }
    
    return sum; 
  }


}