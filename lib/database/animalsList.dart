
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/database/db.dart';

import '../model/Animal.dart';

class AnimalsList extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Animals"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
            Navigator.pushNamed(context, "/edit", arguments: Animal(id: 0, name: "", type: ""));
        },
      ),
      body: Container(
        child: Animals(),
      ),
    );
  }

}

class Animals extends StatefulWidget {
  @override
  _List createState() => _List();
}

class _List extends State<Animals> {

  List<Animal> animals = [];

  @override
  void initState(){
    loadAnimals();
    super.initState();
  }

  loadAnimals() async{
    List<Animal> animalsAux = await DB.findAll();

    setState(() {
      animals = animalsAux;
    });
  }

  @override
  Widget build(BuildContext context) {
   return ListView.builder(
       itemCount: animals.length,
       itemBuilder: (context, i) =>
         Dismissible(
         key: Key(i.toString()),
         direction: DismissDirection.startToEnd,
           background: Container(
             color: Colors.red,
             padding: EdgeInsets.only(left: 5),
             child: Align(
               alignment: Alignment.centerLeft,
               child: Icon(Icons.delete, color: Colors.white),
             ),
           ),
           onDismissed: (direction){
            DB.delete(animals[i]);
           },
           child: ListTile(
             title: Text(animals[i].name),
             trailing: MaterialButton(
               onPressed: (){
                  Navigator.pushNamed(context, "/edit", arguments: animals[i]);
               },
               child: Icon(Icons.edit),
             ),
           ),
       )
   );
  }

}