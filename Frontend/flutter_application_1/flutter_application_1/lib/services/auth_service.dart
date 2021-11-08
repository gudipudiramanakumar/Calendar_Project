import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }

  String? validatePassword(String? value) {
    String pattern =
        r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!) || value == null)
      return 'Password should contain atleast one Capital Letter, Number and Special Character';
    else
      return null;
  }

  // sign in
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign up
  Future signUp(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //google sign in
  // Future googleSignIn() async {
  //   try {
  //     GoogleSignIn googleSignIn = GoogleSignIn();
  //     GoogleSignInAccount account = await googleSignIn.signIn();
  //     if (account != null) {
  //       GoogleSignInAuthentication googleAuth = await account.authentication;
  //       if (googleAuth.idToken != null && googleAuth.accessToken != null) {
  //         final AuthCredential credential = GoogleAuthProvider.credential(
  //           accessToken: googleAuth.accessToken,
  //           idToken: googleAuth.idToken,
  //         );
  //         UserCredential result = await auth.signInWithCredential(credential);
  //         User? user = result.user;
  //         return user;
  //       } else {
  //         return null;
  //       }
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
