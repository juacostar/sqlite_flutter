
import 'package:flutter_sqlite/model/Animal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{

  static Future<Database> createDB() async {
    return openDatabase(join(await getDatabasesPath(), 'animals.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE ANIMALS (id INTEGER PRIMARY KEY, name TEXT, type TEXT)"
        );
      }, version: 1
    );
  }

  static Future<int> insert(Animal animal) async {
    Database database = await createDB();
    
    return database.insert("animals", animal.toMap());
  }

  static Future<int> delete(Animal animal) async {
    Database database = await createDB();

    return database.delete("animals", where: "id = ?", whereArgs: [animal.id]);
  }

  static Future<int> update(Animal animal) async {
    Database database = await createDB();

    return database.update("animals", animal.toMap(), where: "id = ?", whereArgs: [animal.id]);
  }

  static Future<List<Animal>> findAll() async {
    Database database = await createDB();

    final List<Map<String, dynamic>> animals = await database.query("animals");

    return List.generate(animals.length
        , (index) => Animal(id: animals[index]['id'], name: animals[index]['name'], type: animals[index]['type']));
  }



}