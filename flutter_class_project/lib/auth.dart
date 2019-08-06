import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';





abstract class BaseAuth {
  Future<String> signInWithGoogle();
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}
class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;




  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }







  @override
  Future<String> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser currentUser;

      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken, );
      final AuthResult user = await _auth.signInWithCredential(credential);
      currentUser = await _auth.currentUser();
      assert(user.user.uid == currentUser.uid);
      print(currentUser);
      print("User Name : ${currentUser.displayName}");



      return user.user.uid;

  }








}