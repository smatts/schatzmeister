import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:schatzmeister/controller.dart';
import 'package:schatzmeister/model/booking.dart';
import 'package:schatzmeister/assets/input_field.dart';

class AddTransaction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddTransactionsState();
  }
}

enum TransactionType { bar, konto }

class _AddTransactionsState extends StateMVC {
  TransactionType _type = TransactionType.bar;
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  _AddTransactionsState(): super(Controller()) {
    _con = Controller.con;
  }

  Controller _con;

  int _getTypeAsInt(TransactionType type) {
    if (type == TransactionType.bar) return 0;
    return 1;
  }

  void _add(double amount, String name, String description, TransactionType type, String date) async {
    Booking booking = Booking(amount: amount, person: name, description: description, type: _getTypeAsInt(type), date: date);
    _con.insertBooking(booking);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaktion hinzufügen"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              InputFieldArea(
                controller: _amountController,
                label: 'Betrag',
                hint: '€',
                inputType: TextInputType.number,
              ),
              InputFieldArea(
                controller: _nameController,
                label: 'Name',
                inputType: TextInputType.text,
              ),
              InputFieldArea(
                controller: _descriptionController,
                label: 'Beschreibung',
                inputType: TextInputType.text,
              ),
              RadioListTile<TransactionType>(
                title: const Text('Bar'),
                value: TransactionType.bar,
                groupValue: _type,
                onChanged: (TransactionType value) { setState(() { _type = value; }); },
              ),
              RadioListTile<TransactionType>(
                title: const Text('Konto'),
                value: TransactionType.konto,
                groupValue: _type,
                onChanged: (TransactionType value) { setState(() { _type = value; }); },
              ),
              RaisedButton(
                child: Text('Speichern'),
                onPressed: () {
                    _add(double.parse(_amountController.text.replaceAll(',', '.')), _nameController.text, _descriptionController.text, _type, DateFormat('dd.MM.yy').format(DateTime.now().toLocal()));
                },
              )],
            ),
        )
    ));
  }
}
