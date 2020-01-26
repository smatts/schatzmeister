import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:schatzmeister/model/model.dart';
import 'package:schatzmeister/model/booking.dart';

class Controller extends ControllerMVC {
  Model _model;
  Future<Database> database;
  String _title;

  factory Controller() {
    if (_this == null) _this = Controller._();
    return _this;
  }

  static Controller _this;
  Controller._();
  static Controller get con => _this;

  get model => _model;
  get title => _title;

  void init(String title) {
    _title = title;
    _model = new Model();
    database = initDB();
    updateBookings();
  }

  void printBookings() {
    bookings().then((booking) => print(booking))
        .catchError((error) => print(error.toString()));
  }

  Future<Database> initDB() async {
    return database = openDatabase(
      join(await getDatabasesPath(), 'bookings_database.db'),

      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE bookings(id INTEGER PRIMARY KEY, amount DOUBLE, person TEXT, type INTEGER, description TEXT, date TEXT)",);
      },
      version: 1,
    );
  }

  Future<void> insertBooking(Booking booking) async {
    final Database db = await database;

    await db.insert(
      'bookings',
      booking.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    updateBookings();
  }

  Future<void> updateBooking(Booking booking) async {
    final db = await database;

    await db.update(
      'bookings',
      booking.toMap(),
      where: "id = ?",
      whereArgs: [booking.id],
    );

    updateBookings();
  }

  Future<void> deleteBooking(int id) async {
    final db = await database;

    await db.delete(
      'bookings',
      where: "id = ?",
      whereArgs: [id],
    );


    updateBookings();
  }

  Future<void> clearAll() async {
    final db = await database;

    await db.delete('bookings');

    updateBookings();
  }

  Future<List<Booking>> bookings() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('bookings');

    return List.generate(maps.length, (i) {
      return Booking(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        person: maps[i]['person'],
        type: maps[i]['type'],
        description: maps[i]['description'],
        date: maps[i]['date'],
      );
    });
  }

  void updateBookings() async {
    await bookings().then((bookings) => {
      model.bookings = bookings
    });

    model.updateStats();
  }
}
