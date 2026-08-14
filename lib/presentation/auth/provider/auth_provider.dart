import 'package:firebase_auth/firebase_auth.dart';
import 'package:kauto/data/auth/datasource/auth_remote_datasource.dart';
import 'package:kauto/data/auth/repository/auth_repository_iml.dart';
import 'package:riverpod/riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepositoryIml(datasource: AuthRemoteDatasource()),
);
final authProvider = StreamProvider((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
