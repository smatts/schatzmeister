import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:schatzmeister/controller.dart';

class TransactionOverview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransactionState();
  }
}

class _TransactionState extends StateMVC {
  List<DataRow> _rows = [];

  _TransactionState(): super(Controller()) {
    _con = Controller.con;
  }

  Controller _con;

  @override
  initState() {
    super.initState();

    update();
  }

  Text _createHeaderText(String label) {
    return Text(label,
        style: new TextStyle(fontWeight: FontWeight.bold)
    );
  }

  List<DataColumn> _createHeader(List label) {
    List<DataColumn> columns = [];

    for (int i = 0; i < label.length; i++) {
      columns.add(DataColumn(
          label: _createHeaderText(label[i])
      ));
    }

    return columns;
  }

  String typeText(int type) {
    if (type == 0) return "Bar";
    return "Konto";
  }


  void update() {
    _rows.clear();

    for (var booking in _con.model.bookings) {
      _rows.add(DataRow(cells: [
        DataCell(Text(booking.date)),
        DataCell(Text(booking.amount.toStringAsFixed(2) + '€')),
        DataCell(Text(booking.person)),
        DataCell(Text(booking.description ?? "")),
        DataCell(Text(typeText(booking.type))),
      ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaktionen"),
      ),
      body: SingleChildScrollView(
          child: Container(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: _createHeader(['Datum', 'Betrag', 'Person', 'Beschreibung', 'Typ']),
                    rows: _rows,
                  ),
                )
            ),
          ),
    );
  }
}
