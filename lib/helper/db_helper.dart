import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class DBHelper {
  static const userDetail = 'user_detail';
  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(path.join(dbPath, 'person_detail.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_detail(id TEXT PRIMARY KEY,name TEXT,email TEXT,mobile TEXT,gender INTEGER,cardColor INTEGER,empName TEXT,empEmail TEXT,designation TEXT,accountNo TEXT,accountHolderName TEXT,ifscCode TEXT,bankName TEXT)');
    }, version: 1);
  }

  static Future<void> insert(Map<String, Object> data) async {
    final sqlDb = await DBHelper.getDatabase();
    sqlDb.insert(userDetail, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.getDatabase();
    return db.query(userDetail);
  }

  static Future<void> update(Map<String, Object> data, String id) async {
    final sqlDb = await DBHelper.getDatabase();
    sqlDb.update(userDetail, data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteUser(String id) async {
    final db = await DBHelper.getDatabase();
    db.delete(userDetail, where: 'id = ?', whereArgs: [id]);
  }
}
