import 'package:firebase_database/firebase_database.dart';

import '../../domain/repositories/repositories.dart';
import '../datasources/datasource.dart';

class CoreRepositoryImpl implements CoreRepository {
  final FirebaseDataSource _dataSource;

  CoreRepositoryImpl({required FirebaseDataSource dataSource})
      : _dataSource = dataSource;

  @override
  DatabaseReference ref(String? path) => _dataSource.database.ref(path);
}
