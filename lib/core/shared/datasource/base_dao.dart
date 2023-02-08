import 'dart:async';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';
import 'entity.dart';

// Data Access Object
abstract class BaseDAO<T extends Entity> {
  Future<Database> get db => DatabaseHelper.getInstance().db;
  String get tableName;
  T fromMap(Map<String, dynamic> map);

  Future<int> save(T entity) async {
    try {
      var dbClient = await db;
      var id = await dbClient.insert(tableName, entity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    } on DatabaseException catch (e) {
      AppLog.d("{ Base Dao } Não foi possível salvar o registro ${e.toString()}", name: 'BaseDaoSave');
      return 0;
    }
  }

  Future<List<T>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $tableName');
    return list.map<T>((json) => fromMap(json)).toList();
  }

  Future<T?> findById(int id) async {
    var dbClient = await db;
    final list = await dbClient.rawQuery('select * from $tableName where id = ?', [id]);

    if (list.length > 0) {
      return fromMap(list.first);
    }
    return null;
  }

  Future<bool> exists(int id) async {
    T? c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $tableName');
    return Sqflite.firstIntValue(list);
  }

  Future<int> update(T entity, int id) async {
    try {
      var dbClient = await db;
      var totalUpdate = await dbClient.update(tableName, entity.toMap(), where: "id = ?", whereArgs: [id], conflictAlgorithm: ConflictAlgorithm.replace);
      return totalUpdate;
    } on DatabaseException catch (e) {
      AppLog.d("{Base Dao } Não foi possível atualizar o dado ${e.toString()}");
      return 0;
    }
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName');
  }
}
