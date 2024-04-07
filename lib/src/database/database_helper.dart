import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper.internal();
  factory DatabaseHelper() => _databaseHelper;
  DatabaseHelper.internal();

  static Database? _database;

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), "maids.db");

    return await _open(path);
  }

  Future _open(String path) async {
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int version) async {
    return await db.execute("""CREATE TABLE IF NOT EXISTS task(
              task_id INTEGER PRIMARY KEY AUTOINCREMENT,

              id INTEGER NOT NULL,
              email TEXT,
              first_name TEXT,
              last_name TEXT,
              avatar TEXT
              )""");
  }
}
