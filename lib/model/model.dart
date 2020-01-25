import 'booking.dart';

class Model {
  double _cashBalance = 0.0;
  double _accountBalance = 0.0;
  List<Booking> _bookings;

  double get chashBalance => _cashBalance;
  double get accountBalance => _accountBalance;
  double get balance => _cashBalance + _accountBalance;
  List<Booking> get bookings => _bookings;

  Model() {
    _bookings = [];
  }

  set accountBalance(double value) {
    _accountBalance = value;
  }

  set chashBalance(double value) {
    _cashBalance = value;
  }

  set bookings(List<Booking> bookings) {
    _bookings = bookings;
  }

  void updateStats() {
    for (var booking in _bookings) {
      if (booking.type == 0) {
        _cashBalance += booking.amount;
      } else {
        _accountBalance += booking.amount;
      }
    }
  }

}