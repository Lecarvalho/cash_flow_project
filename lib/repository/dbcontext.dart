import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbContext {
  static final DbContext _singleton = DbContext._internal();
  DbContext._internal();
  factory DbContext() {
    return _singleton;
  }

  Database cashFlowDb;

  Future<void> copyDatabaseFromAssets(String dbName) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "db", dbName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);

    // open the database
    cashFlowDb = await openDatabase(path, version: 1);
  }

  Future<void> initDB(String dbName) async {
    var pathDatabase = join(await getDatabasesPath(), dbName);
    var exists = await databaseExists(pathDatabase);

    if (exists) {
      print("db exists, reading db...");
      cashFlowDb = await openDatabase(
        pathDatabase,
        version: 1,
      );

    } else {
      print("Coping db from assets...");
      await copyDatabaseFromAssets(dbName);
    }
    print("db ready!");
  }
}
