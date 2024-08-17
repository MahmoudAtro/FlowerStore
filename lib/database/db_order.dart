
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbOrder {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "mahmoud.db");
    Database mydb = await openDatabase(path, onCreate: _oncreate , version: 1);
    return mydb;
  }

  _oncreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "orders" (
      "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
      "name"	TEXT NOT NULL,
      "price"	INTEGER NOT NULL,
      "quantity" INTEGER NOT NULL,
      "date" TEXT NOT NULL
    )
''');
    print("create database and table==========================");
  }

  Future<List<Map<String, dynamic>>> read() async {
    Database? mydb = await db;
    List<Map<String , dynamic>> response = await mydb!.query("orders");
    return response;
  }


  insert(Map<String, Object?> value) async {
    Database? mydb = await db;
    int response = await mydb!.insert("orders", value);
    return response;
  }

  delete() async {
    Database? mydb = await db;
    int response = await mydb!.delete("orders");
    return response;
  }


  // delete dataBase
  // deletedatabase() async {
  //   String dbPath = await getDatabasesPath();
  //   String path = join(dbPath, "mahmoud.db");
  //   await deleteDatabase(path);
  // }
}