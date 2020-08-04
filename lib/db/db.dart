import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Database _instance;

  static final DB _db = DB._init();

  DB._init();

  factory DB() {
    return _db;
  }

  Future<Database> getInstance() async {
    if (_instance == null) {
      _instance = await _createDB();
    }

    return _instance;
  }

  Future<Database> _createDB() async {
    final pathDb = await getDatabasesPath();
    final database = await openDatabase(
      join(pathDb, 'formulario_cadastro.db'),
      onCreate: (db, version) {
        return db.execute('''
        create table users (
          id integer primary key autoincrement,
          nome text not null,
          email text,
          cpf text,
          endereco text 
        );
      ''');
      },
      version: 1,
    );

    return database;
  }
}
