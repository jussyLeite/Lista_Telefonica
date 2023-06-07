import 'package:data_bloc/model/Contacto.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSource {

  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE contacto(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, telefone TEXT NOT NULL)"
        );
      },
      version: 1,
    );
  }

  Future<int> createItem(Contacto contacto) async{
    int result = 0;
    final Database db = await initializedDB();
    final id = await db.insert('contacto', contacto.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace
    );
     print(id);
    return id;
  }

  Future<List<Contacto>> getItems() async {
    final db = await initializedDB();
    final List<Map<String, Object?>> queryResult = 
      await db.query('contacto');
     
    return queryResult.map((e) => Contacto.fromMap(e)).toList();
  }

  Future<Contacto> getItem(int id) async {
    final db = await initializedDB();
    final  queryResult =  await db.query("contacto", where: 'id = ?', whereArgs: [id]);

    if (queryResult.isNotEmpty){
      return Contacto.fromMap(queryResult.first);
    } else {
      throw Exception("ID $id not found!");
    }
  }

  Future<void> delete(int id) async {
    final db = await initializedDB();
    try
    {
      await db.delete("contacto", where: 'id = ?', whereArgs: [id]);
    } catch (err){
      debugPrint("Alguma coisa deu errado! $err");
    }
  }


}