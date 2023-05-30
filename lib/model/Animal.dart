
class Animal{

  int id;
  String name;
  String type;

  Animal({required this.id, required this.name, required this.type});

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'type':type
    };
  }
}