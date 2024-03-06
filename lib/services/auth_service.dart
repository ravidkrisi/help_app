import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_app/model/user.dart';
import 'package:help_app/services/user_service.dart';
import 'package:help_app/utils/enums.dart';
import 'package:help_app/utils/result.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  // sign in user
  Stream<Result<AppUser>> signInWithEmailAndPassword(
      String email, String password) async* {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;

      // sign in succeed
      if (user != null) {
        // user successfully signed in, get user data from fireStore
        yield* _userService.getUserById(user.uid);
      }
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  Future<Result<AppUser?>?> signUpWithEmailAndPassword(
      String email, String password, String name, UserType type) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        // User successfully registered, create user in Firestore
        // case 1: customer
        if (type == 1) {
          return await _userService.addUserToFirestore(CustomerUser(
              uid: user.uid, email: email, name: name, type: type));
        }
        // case 2: provider
        else if (type == 2) {
          return await _userService.addUserToFirestore(ProviderUser(
              uid: user.uid, email: email, name: name, type: type));
        }
      }
    } catch (e) {
      print('Error registering: $e');
      return null;
    }
    return null;
  }

  // check if a user is already logged in
  Stream<Result<AppUser>> isUserLoggedIn() async* {
    User? currUser = _auth.currentUser;

    // user is already logged in return user
    if (currUser != null) {
      yield* _userService.getUserById(currUser.uid);
    }

    // user not logged in return null
    yield Result.failure(Exception("user not logged in"));
  }

  Future<Result<User>> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        return Result.success(result.user!);
      }
    } on FirebaseAuthException catch (e) {
      return Result.failure(e);
    }
    return Result.failure(
        Exception("Sign-up process did not complete successfully"));
  }

  // sign out user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
