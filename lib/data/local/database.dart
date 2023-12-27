
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_project/data/local/dao/user_data_dao.dart';
import 'package:flutter_project/domain/models/user_data.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [
  UserData
])
abstract class AppDatabase extends FloorDatabase {

  final StreamController<String> _changeListener = StreamController<String>.broadcast();

  Stream<String> get changeListenerStr => _changeListener.stream;

  UserDataDao get userDataDao;
}