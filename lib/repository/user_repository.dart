abstract class UserRepository {
  Future<void> saveUserData(String email, String password);

  Future<Map<String, String?>> getUserData();

  Future<void> clearUserData();

  Future<void> updateEmail(String newEmail);
}