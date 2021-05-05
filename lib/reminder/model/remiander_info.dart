class Remianderinfo {
  int id;
  DateTime remianderDateTime;
  String title;

  Remianderinfo({this.remianderDateTime, this.title, this.id});

  factory Remianderinfo.fromMap(Map<String, dynamic> json) => Remianderinfo(
      id: json["id"],
      title: json["title"],
      remianderDateTime: DateTime.parse(json["remianderDateTime"]));
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "remianderDateTime": remianderDateTime.toIso8601String()
      };
}
