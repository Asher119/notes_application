import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_taking_app/Screens/homeScreen.dart';
import 'package:notes_taking_app/Screens/loginScreen.dart';
import 'package:notes_taking_app/controllers/authController.dart';




class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

checkuser() async{

  var snapshot = await GoogleSignIn().isSignedIn();
  User? user = FirebaseAuth.instance.currentUser;




print("user : $snapshot");
  if(user == true){

    print("User SignIn");
   
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeScreen(),));

  }else{
    print('user Not Sigined');
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }
}

@override
  void initState() {

    Future.delayed(Duration(seconds: 2),() {
      checkuser();
      signInWithGoogle(context);
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Loading'),
      ),
    );
  }
}