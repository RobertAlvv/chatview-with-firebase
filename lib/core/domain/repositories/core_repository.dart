import 'package:firebase_database/firebase_database.dart';

abstract class CoreRepository {
  DatabaseReference ref(String? path);
}
