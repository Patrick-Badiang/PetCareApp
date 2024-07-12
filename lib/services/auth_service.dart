import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  //Google  Sign In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in process, gUser will be null
      if (gUser == null) {
        // Optionally, handle the case where the user cancels the sign-in process
        return null;
      }

      // Obtain auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Then sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Optionally, handle any errors that occur during sign-in
      print("Error signing in with Google: $e");
      return null;
    }
  }

}