import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    band_name TEXT,
    genre_name TEXT,
    member_name TEXT,
    instrument_name TEXT,
    song_name TEXT,
    release_year TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('band.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      if (kDebugMode) {
        print('...creating a table...');
      }
      await createTables(database);
    });
  }

  static Future<int> createItem(String bandName, String genreName) async {
    final db = await SQLHelper.db();

    final data = {
      'band_name': bandName,
      'genre_name': genreName,
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: 'id= ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String bandName, String genreName,) async {
    final db = await SQLHelper.db();

    final data = {
      'band_name': bandName,
      'genre_name': genreName,
      'createdAt': DateTime.now().toString(),
    };

    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<int> updateItemMember(int id, String member, String instrument) async {
    final db = await SQLHelper.db();

    final data = {
      'member_name': member,
      'instrument_name': instrument,
    };

    final result = await db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<int> updateItemSong(int id, String song, String year) async {
    final db = await SQLHelper.db();

    final data = {
      'song_name': song,
      'release_year': year,
    };

    final result = await db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong: $err');
    }
  }
}
