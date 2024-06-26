import 'package:notes/Services/Auth/auth_exceptions.dart';
import 'package:notes/Services/Auth/auth_provider.dart';
import 'package:notes/Services/Auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized to begin with', () {
      expect(provider._isInitialized, false);
    });

    test('Cannot log out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializeException>()),
      );
    });

    test('Should be able to initialized', () async{
      await provider.initialize();
      expect(
        provider.isInitialized, true);
    });

    test('User should be null after initialization', () async{
      expect(
          provider.currentUser, null);
    });

    test('Should be able to initialize in less than 2 seconds', () async{
      await provider.initialize();
      expect(
          provider.isInitialized, true);
    },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('Create user should delegate logIn function', () async{
      final badEmailUser = provider.createUser(email: 'test@gmail.com', password: 'anypassword');
      expect(
          badEmailUser,
          throwsA(const TypeMatcher<WrongEmailOrPasswordAuthException>()));

      final badPasswordUser = provider.createUser(email: 'anyemail@gmail.com', password: '123456789');
      expect(
          badPasswordUser,
          throwsA(const TypeMatcher<WrongEmailOrPasswordAuthException>()));

      final user = await provider.createUser(email: 'okay@gmail.com', password: '15926');
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(
          user, isNotNull);
      expect(user!.isEmailVerified, true);
    });
    
    test('Should be able to log out and log in again', () async{
      await provider.logOut();
      await provider.logIn(email: 'email', password: 'password');
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}
class NotInitializeException implements Exception {

}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async
  {
    if (!isInitialized) throw NotInitializeException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializeException();
    if (email == 'test@gmail.com') throw WrongEmailOrPasswordAuthException();
    if (password == '123456789') throw WrongEmailOrPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async{
    if (!isInitialized) throw NotInitializeException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializeException();
    final user = _user;
    if (user == null) throw UserNotLoggedInAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }

}