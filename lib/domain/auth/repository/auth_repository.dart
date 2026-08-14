abstract class AuthRepository {
  Future<void> login(String email, String pass);
  Future<void> signup(String email, String pass);
  Future<void> signInWithGoogle();
  Future<void> signOut();
}