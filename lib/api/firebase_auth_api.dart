import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  // return current logged in user
  User? getUser() {
    return auth.currentUser; // currentUser built in in firebase auth
  }


  // return stream of user
  Stream<User?> userSignedIn() {
    return auth.authStateChanges(); // listens to changes in authentication status
    // check if merong nakasign in o wala
  }

  Future<void> signUp(String email, String password) async{
    UserCredential credential;

    try{
      credential = await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password);

        print(credential);

    } on FirebaseAuthException catch (e) {
      if(e.code == 'email-already-in-use'){ // error messages built in in firebase auth
        print("The account already exists for that email");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> signIn(String email, String password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "";
    } on FirebaseAuthException catch (e) {
      if(e.code == 'invalid-email') {
        return e.message;
      } else if(e.code == 'invalid-credential'){
        return e.message;
      }else {
        return 'Failed at ${e.code}: ${e.message}';
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

}