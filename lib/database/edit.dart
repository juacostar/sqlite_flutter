

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/database/db.dart';
import 'package:flutter_sqlite/model/Animal.dart';

class Edit extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();

  @override
  Widget build(BuildContext context){
    Animal? animal = ModalRoute.of(context)?.settings.arguments as Animal?;
    nameController.text = animal!.name;
    typeController.text = animal!.name;

    return Scaffold(
        appBar: AppBar(
          title: Text("Save"),
        ),
      body: Container(
        child: Padding(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  validator: (value){
                    if(value!.isEmpty)
                      return "name is mandatory";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name"
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: typeController,
                  validator: (value){
                    if(value!.isEmpty)
                      return "type is mandatory";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Type"
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        if(animal.id > 0){
                          animal.name = nameController.text;
                          animal.type = typeController.text;
                          DB.update(animal);
                        }else{
                          DB.insert(Animal(id: Random().nextInt(100), name: nameController.text, type: typeController.text));
                          Navigator.pushNamed(context, "/");
                        }
                      }
                    },
                    child: Text("Guardar"))
              ],
            ),
          ),
          padding: EdgeInsets.all(15),
        ),
      ),
    );
  }

}