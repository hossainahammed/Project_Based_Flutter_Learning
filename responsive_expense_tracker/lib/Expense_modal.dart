class Expense{
  String title;
  double amount;
  DateTime date;
  String category;



  Expense({ //In OOP it is a constructor
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });


  // Convert a Expense object into a Map object
  Map<String, dynamic> toJson() => {
    'title': title,
    'amount': amount,
    'date': date.toIso8601String(),
    'category': category,
  };

  // Extract a Expense object from a Map object
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }
}

