class ExpenseInfo {
  int id;
  String category;
  int amount;
  String title;

  ExpenseInfo({this.category, this.amount, this.id, this.title});

  factory ExpenseInfo.fromMap(Map<String, dynamic> json) => ExpenseInfo(
      id: json["id"],
      amount: json["amount"],
      category: json["category"],
      title: json["title"]);
  Map<String, dynamic> toMap() =>
      {"id": id, "amount": amount, "category": category, "title": title};
}
