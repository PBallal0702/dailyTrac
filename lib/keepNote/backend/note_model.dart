

class NoteModel{
  final int id;
  final String title;
  final String description;

  NoteModel({this.id,this.title,this.description});

  Map<String,dynamic>toMap(){
    var map = Map<String,dynamic>();
    map['id' ]=this.id;
    map['title']=this.title;
    map['description']=this.description;
    return map;
  }
}