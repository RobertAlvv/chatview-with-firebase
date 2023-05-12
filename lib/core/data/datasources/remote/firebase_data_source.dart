import 'package:firebase_database/firebase_database.dart';

class FirebaseDataSource {
  static final FirebaseDataSource _instance = FirebaseDataSource._internal();

  factory FirebaseDataSource() => _instance;

  late FirebaseDatabase database;

  FirebaseDataSource._internal() {
    database = FirebaseDatabase.instance;
  }
}
