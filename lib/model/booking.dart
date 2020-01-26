class Booking {
  int id;
  double amount;
  String person;
  int type;
  String description;
  String date;

  Booking({this.id, this.amount, this.person, this.type, this.description, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'person': person,
      'type': type,
      'description': description,
      'date': date,
    };
  }

  @override
  String toString() {
    return "("+id.toString()+", "+date+ ", " + amount.toString() + ", "+person+", "+type.toString()+", "+description+")";
  }
}

