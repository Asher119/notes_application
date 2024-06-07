

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_taking_app/Screens/viewnote.dart';


class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  GoogleSignIn googleSignIn = GoogleSignIn();

  CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notes');
      
  List<Color> CardColors = [

    Colors.yellow.shade200,
    Colors.red.shade200,
    Colors.pink.shade200,
    Colors.deepPurple.shade200,

  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height/1,
          child: StreamBuilder<QuerySnapshot>(
            stream: ref.snapshots(),

            builder: (context,AsyncSnapshot snapshot) {

            if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    Random random = Random();
          
                    Color bg = CardColors[random.nextInt(4)];
          
                    Map<String, dynamic> dataMap = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                       
                    //  Map dataa =snapshot.data!.docs[index].data();
          
                   var myDateTime = dataMap['time'];
          
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewNoteScreen(
                                  data: dataMap,
                                  ref: snapshot.data!.docs[index].reference,
                                  time: myDateTime.toString()
                                  
                                  ),
                            )).then((value) {
                          setState(() {});
                        });
   
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: bg,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataMap['title'],
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${myDateTime}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                dataMap['content'],
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("Loading data"),
                );
              }

            
          },),
        ),
      ),
    );
  }
}

