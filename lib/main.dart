import 'package:flutter/material.dart';
import 'controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:schatzmeister/model/transactions.dart';
import 'package:schatzmeister/model/add_entry.dart';

void main() => runApp(Schatzmeister());

class Schatzmeister extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schatzmeister',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Overview(title: 'Kassenbestand'),
    );
  }
}

class Overview extends StatefulWidget {
  Overview({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OverviewState createState() => _OverviewState(title);
}

class _OverviewState extends StateMVC {
  _OverviewState(String title): super(Controller()) {
    _con = Controller.con;
    _con.init(title);
  }

  Controller _con;

  double _getBalance() {
    double balance = 0.0;

    for (var booking in _con.model.bookings) {
      balance += booking.amount;
    }

    return balance;
  }

  double _getAccountBalance() {
    double balance = 0.0;

    for (var booking in _con.model.bookings) {
      if (booking.type == 1) {
        balance += booking.amount;
      }
    }

    return balance;
  }

  double _getCashBalance() {
    double balance = 0.0;

    for (var booking in _con.model.bookings) {
      if (booking.type == 0) {
        balance += booking.amount;
      }
    }

    return balance;
  }

  Column _balanceColumn(String label, double value) {
    Color color;

    if (value == 0) {
      color = Colors.grey;
    } else if (value > 0) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }

    return Column(
        children: <Widget>[
          Text(
            value.toStringAsFixed(2) + "€",
            style: new TextStyle(
                color: color, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
          ),
        ]
    );
  }

  void rebuild(BuildContext context) {
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Übersicht'),
      ),
      body: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _balanceColumn('Gesamt', _getBalance()),
              _balanceColumn('Konto', _getAccountBalance()),
              _balanceColumn('Kasse', _getCashBalance()),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            child: Text('Transaktionen anzeigen'),
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionOverview()),
              );
            },
          )
        ),
        Container(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: Text('Transaktion hinzufügen'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransaction()),
                );
              },
            )
        ),
        Container(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: Text('Alles löschen'),
              color: Colors.red,
              onPressed: () {
                _con.clearAll();
              },
            )
        )
      ]),
    );
  }
}
