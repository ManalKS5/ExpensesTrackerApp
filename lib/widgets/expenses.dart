
import 'package:budget_app/widgets/chart/chart.dart';
import 'package:budget_app/widgets/expenses_list/expenses_list.dart';
import 'package:budget_app/models/expense.dart';
import 'package:budget_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesStat();
  }
}

class _ExpensesStat extends State<Expenses>{
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'flutter course', 
      amount: 75.50, 
      date: DateTime.now(), 
      category: MyCategory.work),
      Expense(
      title: 'cinema', 
      amount: 50, 
      date: DateTime.now(), 
      category: MyCategory.leisure)
  ];

  void _openAddExpensesOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx) =>  newExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense){
    setState(() {
       _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenceIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenceIndex, expense);
            });
          },
          ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    Widget mainContent = const Center(
      child: Text('No expenses found.\t Start adding now!'),
    );

    if (_registeredExpenses.isNotEmpty){
      mainContent =ExpensesList(
              expenses: _registeredExpenses,
              onRemoveExpense: _removeExpense,
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay, 
            icon: const Icon(Icons.add)
          ),
      ],),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
        ),
    );
  }
}