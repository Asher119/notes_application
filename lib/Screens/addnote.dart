import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String title = '';
  String content = '';


  final TextEditingController _title = TextEditingController();
 final TextEditingController _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          add();
                        },
                        style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder()),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'latoreg',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: _title,
                      decoration: InputDecoration.collapsed(hintText: 'Title'),
                      style: const TextStyle(
                          fontSize: 32,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: null,
                      decoration:      
                          InputDecoration.collapsed(hintText: 'Content'),
                      style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'latoreg',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      controller: _content,
                    ),
                  ],
                )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notes');
        
 DateTime now = DateTime.now();
  DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);
  
  String formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(currentTime);
  print(formattedTime);


        var data ={
          'title':_title.text,
          'content':_content.text,
          'time':formattedTime,
        };

        ref.add(data);


    
    Navigator.pop(context);


  }
}
