import 'package:flutter/material.dart';
import 'package:budget_app/models/expense.dart';





class newExpense extends StatefulWidget{
  const newExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;


  @override
  State<newExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<newExpense>{

  /* SOLUTION 1 TO SAVE USER INPUTS
  var _enteredTitle = '';

  void _saveTitleInput(String input){
    _enteredTitle = input;
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          onChanged: _saveTitleInput,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('Title')
          ),
        ),
        Row(children: [
          ElevatedButton(onPressed: (){}, child: Text('save expense'))
        ],)
      ]),
    );
  }*/ 

//second solution
 final _titleController = TextEditingController();
 final _amountController = TextEditingController();

 DateTime? _selectedDate;

 @override
  void dispose() {
    // you have to ADD this method or the object will stay a live
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }


  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now); 

      setState(() {
        _selectedDate = pickedate;
      });
  }

  MyCategory _selectedCategory = MyCategory.leisure;

  // to validate user inputs 

  void _submitExpenseData(){
    
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if(_titleController.text.trim().isEmpty || 
    amountIsInvalid ||
    _selectedDate == null){
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: const Text('INVALID INPUT'),
          content: const Text('please make sure a valid title, amount,date and category was entered.'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(ctx);
            }, 
            child: const Text('Okay'),),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text, 
        amount: enteredAmount, 
        date: _selectedDate!, 
        category: _selectedCategory
      )
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext contMyt) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('Title')
          ),
        ),

        Row(children: [
          Expanded(
            child: TextField(
            controller: _amountController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '\$ ',
              label: Text('Aomunt')
            ),
            ),
          ),
          const SizedBox(width: 16,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Text(_selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!),),
              IconButton(
                onPressed: _presentDatePicker, 
                icon: const Icon(
                  Icons.calendar_month
                )
              ),
            ],),
          )
        ],
        ),
        const SizedBox(height:  16,),
        Row(children: [
          DropdownButton(
            value: _selectedCategory,
            items: MyCategory.values.map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(category.name.toUpperCase(),
                ),
               ),
              ).toList(), 
            onChanged: (value){
              setState(() {
                if(value == null){
                  return;
                                }
                   _selectedCategory = value;
                    });
            },
          ),
          const Spacer(),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, 
          child: const Text('cancel')),
          ElevatedButton(
            onPressed: _submitExpenseData, 
            child: const Text('save expense'),
            ),
        ],)
      ]),
    );
  }

}