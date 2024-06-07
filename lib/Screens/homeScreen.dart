import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_taking_app/Screens/addnote.dart';
import 'package:notes_taking_app/Screens/loginScreen.dart';
import 'package:notes_taking_app/Screens/tabs/noteshome.dart';
import 'package:notes_taking_app/consts/constants.dart';
import 'package:notes_taking_app/controllers/authController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue.shade500,
        width: 250,
        child: ListView(children: [
          DrawerHeader(
            child: Container(
              height: 100,
              width: 100,
              decoration:  BoxDecoration(shape: BoxShape.circle,color: Colors.amber,image: DecorationImage(image: NetworkImage(image,scale: 0.5))),
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  email,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                ),
                FilledButton(
                    onPressed: () async {
                      await googleSignIn.signOut();
                      await FirebaseAuth.instance.signOut();
                      FirebaseAuth.instance.currentUser;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text('Log Out'))
              ],
            ),
          ),
        ]),
      ),
      body: const NotesHome(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNoteScreen(),
              )).then((value) {
            print('Calling SetState');
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
