import 'package:kauto/data/auth/datasource/auth_remote_datasource.dart';
import 'package:kauto/domain/auth/repository/auth_repository.dart';

class AuthRepositoryIml extends AuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryIml({required this.datasource});

  @override
  Future<void> login(String email, String password) {
    return login(email, password);
  }

  @override
  Future<void> signInWithGoogle() {
    return datasource.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return datasource.signOut();
  }

  @override
  Future<void> signup(String email, String pass) {
    return datasource.signup(email, pass);
  }
}
