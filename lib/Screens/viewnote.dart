// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewNoteScreen extends StatefulWidget {
  ViewNoteScreen(
      {super.key, required this.data, required this.ref, required this.time});

  final Map data;
  final String time;
  final DocumentReference ref;

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {

  @override
  Widget build(BuildContext context) {

final TextEditingController _title = TextEditingController(text: widget.data['title']);
final TextEditingController _content = TextEditingController(text: widget.data['content']);


          DateTime now = DateTime.now();
          DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);
          
          String formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(currentTime);
          print(formattedTime);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(13),
                  child: Row(
                    
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                        widget.ref.update({
                            'title':_title.text,
                            'time':formattedTime.toString(),
                            'content':_content.text
                        }).whenComplete(() => Navigator.pop(context));
                        },
                        style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder()),
                        child: Icon(Icons.edit)
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: () {
                          delete();
                        },
                        style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder()),
                        child: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                   Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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

                    Text(widget.time,style: TextStyle(color: Colors.red),),
                    SizedBox(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


void delete() async{

      await widget.ref.delete();
      Navigator.pop(context);

  }
}
