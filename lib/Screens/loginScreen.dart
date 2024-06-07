import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_taking_app/Screens/homeScreen.dart';
import 'package:notes_taking_app/controllers/authController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

String email ='this tesr';

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          
          Center(
            
            child:FilledButton(
              onPressed: () async{
           
                signInWithGoogle( );

               

              },
              child: const Text('Signin With Google'),
            ),
          ),
        //  Text(user,style: TextStyle(color: Colors.black),textScaleFactor: 2,),
        ],
      ),
    );
  }
final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    // try {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    // if (googleUser == null) {
    //   // User canceled sign-in
    //   return;
    // }

    GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;

    var userData = {"email": user?.email};
    DocumentSnapshot doc = await users.doc(user?.uid).get();

    if (doc.exists) {
      await doc.reference.update(userData);
    } else {
      await users.doc(user?.uid).set(userData);
    }

    print(user?.photoURL);
    print(user?.email);
    print(user?.uid);

    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
  
  // Future<UserCredential?> signInWithGoogle() async {
  //   await _googleSignIn.signOut();

  //   final GoogleSignInAccount? googleSignInAccount =
  //       await _googleSignIn.signIn();

  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount!.authentication;

  //   final OAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken);

  //   final UserCredential userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);


  //     user = userCredential.user!.displayName!;

    
  //   print(userCredential.user!.displayName);
  //   print(userCredential.user!.email);
  //   print(userCredential.user!.metadata);

  //   print('Connected Sucessfully');
  //   return null;
  // }
}


