import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    band_name TEXT, 
    genre_name TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  );""");
  }

  static Future<void> createTablesMembers(sql.Database database) async {
    await database.execute("""CREATE TABLE members(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    item_id INTEGER NOT NULL,
    member_name TEXT,
    instrument_name TEXT,
    FOREIGN KEY(item_id) REFERENCES items(id)
  );""");
  }

  static Future<void> createTablesSongs(sql.Database database) async {
    await database.execute("""CREATE TABLE songs(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    item_id INTEGER NOT NULL,
    song_name TEXT,
    release_year TEXT,
    FOREIGN KEY(item_id) REFERENCES items(id)
  );""");
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

  static Future<sql.Database> dbMembers() async {
    return sql.openDatabase('bandMembers.db', version: 1,
        onCreate: (sql.Database database, int version) async {
          if (kDebugMode) {
            print('...creating a table...');
          }
          await createTablesMembers(database);
        });
  }

  static Future<sql.Database> dbSongs() async {
    return sql.openDatabase('songs.db', version: 1,
        onCreate: (sql.Database database, int version) async {
          if (kDebugMode) {
            print('...creating a table...');
          }
          await createTablesSongs(database);
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

  static Future<int> createItemMember(int id, String member, String instrument) async {
    final db = await SQLHelper.dbMembers();

    final data = {
      'item_id': id,
      'member_name': member,
      'instrument_name': instrument,
    };

    final result = db.insert('members', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }

  static Future<int> createItemSong(int id, String song_name, String release_year) async {
    final db = await SQLHelper.dbSongs();

    final data = {
      'item_id': id,
      'song_name': song_name,
      'release_year': release_year,
    };

    final result = db.insert('songs', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: 'id= ?', whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getItemMembers(int id) async {
    final db = await SQLHelper.dbMembers();
    return db.query('members', where: 'item_id= ?', whereArgs: [id], limit: null);
  }

  static Future<List<Map<String, dynamic>>> getItemSongs(int id) async {
    final db = await SQLHelper.dbSongs();
    return db.query('songs', where: 'item_id= ?', whereArgs: [id], limit: null);
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

  static Future<void> deleteMember(int id) async {
    final db = await SQLHelper.dbMembers();
    try {
      await db.delete('members', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong: $err');
    }
  }

  static Future<void> deleteSong(int id) async {
    final db = await SQLHelper.dbSongs();
    try {
      await db.delete('songs', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong: $err');
    }
  }
}
