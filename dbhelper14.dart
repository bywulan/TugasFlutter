import 'package:bywulan/tugasday18/usermodel14.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final pathDatabase = join(databasePath, 'turkish_academy.db');

    return await openDatabase(pathDatabase, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        nomor_hp TEXT NOT NULL,
        password TEXT NOT NULL,
        asal_kota TEXT NOT NULL
      )
    ''');
  }

  Future<bool> registerUser(UserModelSQL user) async {
    try {
      final db = await database;

      await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      return true;
    } catch (e) {
      print('Error register user: $e');

      return false;
    }
  }

  Future<List<UserModelSQL>> getUsers() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      orderBy: 'id DESC',
    );

    return List.generate(maps.length, (index) {
      return UserModelSQL.fromMap(maps[index]);
    });
  }

  Future<int> updateUser(UserModelSQL user) async {
    final db = await database;

    return await db.update(
      'users',

      user.toMap(),
      where: 'id = ?',

      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;

    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<UserModelSQL?> loginUser(String email, String password) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return UserModelSQL.fromMap(result.first);
    }

    return null;
  }
}
