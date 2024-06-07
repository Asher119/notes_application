import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_taking_app/Screens/homeScreen.dart';
import 'package:notes_taking_app/consts/constants.dart';

GoogleSignIn googleSignIn = GoogleSignIn();

FirebaseAuth auth = FirebaseAuth.instance;

CollectionReference users = FirebaseFirestore.instance.collection('users');

User? user;

Future signInWithGoogle(BuildContext context) async {

  // await googleSignIn.signOut();

  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {


      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      UserCredential userCredential = await auth.signInWithCredential(credential);
          
          var _isSignIned = await GoogleSignIn().isSignedIn();


      user = userCredential.user;

      print("User Id is : ${userCredential.user!.uid}");

      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
      };

       image = googleSignInAccount.photoUrl!;
       username = googleSignInAccount.displayName!;
       email = googleSignInAccount.email;
    
      users.doc(user!.uid).get().then(
        (doc)=> {
          if (doc.exists) {
            doc.reference.update(userData),
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ))
          } else {
            users.doc(user!.uid).set(userData),  
          }
        },
      );
        print(userData);
        print(userCredential.user?.email!);


      // if(_isSignIned == true){
      //   Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen(),));
      // }

      
    }
  } catch (PlatformException) {
    print(PlatformException);
    print('Signin Not Sucessfull');
  }
 
}



