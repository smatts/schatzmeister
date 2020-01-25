class Booking {
  int id;
  double amount;
  String person;
  int type;

  Booking({this.id, this.amount, this.person, this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'person': person,
      'type': type,
    };
  }

  @override
  String toString() {
    return "("+id.toString() + ", " + amount.toString() + ", "+person+", "+type.toString()+")";
  }
}

