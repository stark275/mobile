import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Db {
  static Future<sql.Database> dbInit() async {
    return sql.openDatabase(
      'fasi.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        """CREATE TABLE students(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        email TEXT,
        password TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute(
        """CREATE TABLE courses(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<List<Map<String, dynamic>>> auth(
      String email, String password) async {
    final db = await Db.dbInit();
    return db.query('students',
        where: "email = ? AND password = ?",
        whereArgs: [email, password],
        limit: 1);
  }

  static Future<int> createStudent(
    String? name,
    String? email,
    String? password,
    String? description,
  ) async {
    final db = await Db.dbInit();

    final data = {
      'name': name,
      'email': email,
      'password': password,
      'description': description,
    };
    final id = await db.insert('students', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;

    // When a UNIQUE constraint violation occurs,
    // the pre-existing rows that are causing the constraint violation
    // are removed prior to inserting or updating the current row.
    // Thus the insert or update always occurs.
  }
}
