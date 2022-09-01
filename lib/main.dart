

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const RunApp());
  await Firebase.initializeApp();
}

class RunApp extends StatelessWidget {
  const RunApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final firestore = FirebaseFirestore.instance;
  @override
  final _textController = TextEditingController();
  final destextController = TextEditingController();

// class NoteList extends StatelessWidget {
//   final db = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    //SingleChildScrollView();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            centerTitle: true,
            title: Text(
              'Your Notes ',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
            )),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('add note'),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                builder: (context) => Container(
                      padding: EdgeInsets.all(16),
                      child: Column(children: [
                        SizedBox(
                          height: 100.0,
                        ),
                        TextFormField(
                          controller: _textController,
                          decoration: InputDecoration(
                            labelText: 'Note Title',
                            prefixIcon: Icon(
                              Icons.title,
                              color: Colors.deepOrangeAccent,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.deepOrangeAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.deepOrangeAccent),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: destextController,
                          decoration: InputDecoration(
                            labelText: 'Note Description',
                            prefixIcon: Icon(
                              Icons.note,
                              color: Colors.deepOrangeAccent,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.deepOrangeAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.deepOrangeAccent),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepOrangeAccent,
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                child: Text('Save Note'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FirstScreen(),
                                      ));
                                  firestore.collection('notes').add({
                                    'title': _textController.text,
                                    'des': destextController.text
                                  });
                                }))
                      ]),
                    ));
          },
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('notes')
                        .snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(Icons.notes),
                                  focusColor: Colors.orangeAccent,
                                  title: Text(
                                      '${snapshot.data!.docs[index]['title']}'),
                                  subtitle: Text(
                                      '${snapshot.data!.docs[index]['des']}'),
                                  trailing: IconButton(icon: Icon(Icons.delete), onPressed: () async {
                                    print(snapshot.data?.docs[index]);
                                    await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                      await myTransaction.delete(snapshot.data!.docs[index].reference);
                                    });
                                  },),
                                );
                              },
                            )
                          : snapshot.hasError
                              ? Text('Error')
                              : CircularProgressIndicator();
                    },
                  ),
                ]),
          ),
        ));
  }
}

