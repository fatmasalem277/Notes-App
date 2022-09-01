

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

// extras
//
//   Container
//
//   (
//
//   child
//
//       :
//
//   Center
//
//   (
//
//   child
//
//       :
//
//   Column
//
//   (
//
// // crossAxisAlignment: CrossAxisAlignment
// //     .start,mainAxisAlignment: MainAxisAlignment.start,
//
//   children
//
//       :
//
//   [
//
//   Column
//
//   (
//
//   children
//
//       :
//
//   [
//
//   ]
//
//   ,
//
//   )
//
//   ,
//
//   Padding
//
//   (
//
// // padding: const EdgeInsets.all(8.0)
//   ,
//
//   child
//
//       :
//
//   ElevatedButton
//
//   (
//
//   style
//
//       :
//
//   ElevatedButton.styleFrom
//
//   (
//
//   primary
//
//       :
//
//   Colors
//       .deepOrangeAccent
//
//   ,
//
//   textStyle
//
//       :
//
//   const TextStyle
//
//   (
//
//   fontSize
//
//       :
//
//   20
//
//   )
//
//   ,
//
//   shape
//
//       :
//
//   RoundedRectangleBorder
//
//   (
//
//   borderRadius
//
//       :
//
//   BorderRadius.circular
//
//   (
//
//   50
//
//   )
//
//   )
//
//   ,
//
//   minimumSize
//
//       :
//
//   Size
//
//   (
//
//   200
//
//   ,
//
//   50
//
//   )
//
//   )
//
//   ,
//
//   onPressed
//
//       : () {
//   SingleChildScrollView();
//   var _textController;
//   showModalBottomSheet(
//   isScrollControlled: true,
//   context: context,
//   shape: RoundedRectangleBorder(
//   borderRadius: BorderRadius.circular(20)
//   ),
//   builder: (context) => Container(
//   padding: EdgeInsets.all(16),
//   child: Column(
//   children: [
//   SizedBox(
//   height: 100.0,
//   ),
//   TextFormField(
//   controller:_textController ,
//   decoration: InputDecoration(
//   labelText: 'Note Title',
//   prefixIcon: Icon(
//   Icons.title,
//   color: Colors.deepOrangeAccent,
//   ),
//   border: OutlineInputBorder(
//   borderSide: BorderSide(color: Colors.deepOrangeAccent),
//
//   borderRadius: BorderRadius.circular(10.0),
//   ),
//   focusedBorder: OutlineInputBorder(
//   borderRadius: BorderRadius.circular(30),
//   borderSide: BorderSide(color: Colors.deepOrangeAccent),
//   ),
//
//   ),
//   ),
//   SizedBox(
//   height: 30.0,
//   ),
//   TextFormField(
//   controller:destextController ,
//   decoration: InputDecoration(
//   labelText: 'Note Description',
//   prefixIcon: Icon(
//   Icons.note,
//   color: Colors.deepOrangeAccent,
//   ),
//   border: OutlineInputBorder(
//
//   borderSide: BorderSide(color: Colors.deepOrangeAccent),
//
//   borderRadius: BorderRadius.circular(10.0),
//   ),
//   focusedBorder: OutlineInputBorder(
//   borderRadius: BorderRadius.circular(30),
//   borderSide: BorderSide(color: Colors.deepOrangeAccent),
//   ),
//
//   ),
//   ),
//   SizedBox(
//   height: 30.0,
//   ),
//   Center(
//   child: ElevatedButton(
//   style:
//   ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent,
//   textStyle: const TextStyle(fontSize: 20),),
//
//   child: Text('Save Note'),
//   onPressed: () {
//   Navigator.push(context,
//   MaterialPageRoute(
//   builder: (context) => FirstScreen(),));
//   firestore.collection('notes').add({
//   'title': _textController.text,
//   'des': destextController.text
//   });
//
//   })
//   )]),
//   ));
//   },
//
//   child
//
//       :
//
//   Text
//
//   (
//
//   '+ Add Note'),
//   ),
//   ),
//
//
//   ],
//   ),
//   ),
//   )
//   ),
//   ],
//   ),
//
//   )
//
//   var db = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(backgroundColor: Colors.deepOrangeAccent,
//           centerTitle: true, title: Text('Your Notes ',
//             style: TextStyle(color: Colors.white,
//                 fontWeight: FontWeight.w800,
//                 fontSize: 25),)),
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//
//             children: [
//               Column(
//                 children: [
//                   StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance.collection('notes')
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       return ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                                 title: Text(
//                                     '${snapshot.data!.docs[index]['title']}'),
//                                 subtitle: Text(
//                                     '${snapshot.data!.docs[index]['des']}'),
//                                 ]
//                             );
//                           });
//                     },
//                   )
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   style:
//                   ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent,
//                       textStyle: const TextStyle(fontSize: 20),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50)),
//                       minimumSize: Size(200, 50)),
//                   onPressed: () {
//                     SingleChildScrollView();
//                     showModalBottomSheet(
//                         isScrollControlled: true,
//                         context: context,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)
//                         ),
//                         builder: (context) =>
//                             Container(
//                               padding: EdgeInsets.all(16),
//                               child: Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 100.0,
//                                     ),
//                                     TextFormField(
//                                       controller: _textController,
//                                       decoration: InputDecoration(
//                                         labelText: 'Note Title',
//                                         prefixIcon: Icon(
//                                           Icons.title,
//                                           color: Colors.deepOrangeAccent,
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Colors.deepOrangeAccent),
//
//                                           borderRadius: BorderRadius.circular(
//                                               10.0),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               30),
//                                           borderSide: BorderSide(
//                                               color: Colors.deepOrangeAccent),
//                                         ),
//
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 30.0,
//                                     ),
//                                     TextFormField(
//                                       controller: destextController,
//                                       decoration: InputDecoration(
//                                         labelText: 'Note Description',
//                                         prefixIcon: Icon(
//                                           Icons.note,
//                                           color: Colors.deepOrangeAccent,
//                                         ),
//                                         border: OutlineInputBorder(
//
//                                           borderSide: BorderSide(
//                                               color: Colors.deepOrangeAccent),
//
//                                           borderRadius: BorderRadius.circular(
//                                               10.0),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               30),
//                                           borderSide: BorderSide(
//                                               color: Colors.deepOrangeAccent),
//                                         ),
//
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 30.0,
//                                     ),
//                                     Center(
//                                         child: ElevatedButton(
//                                             style:
//                                             ElevatedButton.styleFrom(
//                                               primary: Colors.deepOrangeAccent,
//                                               textStyle: const TextStyle(
//                                                   fontSize: 20),),
//
//                                             child: Text('Save Note'),
//                                             onPressed: () {
//                                               Navigator.push(context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         FirstScreen(),));
//                                               firestore.collection('notes').add(
//                                                   {
//                                                     'title': _textController
//                                                         .text,
//                                                     'des': destextController
//                                                         .text
//                                                   });
//                                             })
//                                     )
//                                   ]),
//                             ));
//                   },
//                   child: Text('+ Add Note'),
//                 ),
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//
//
//     );
//   }
// }
//
// body: StreamBuilder<QuerySnapshot>
// (
// // Asyncsnapshot - Querysnapshot
// stream: firestore.collection('
// notes')
// .
// snapshots
// (
// ),builder: (
// context, snapshot){
// return snapshot.hasData ?
// ListView.builder(
// itemCount: snapshot.data!.docs.length,
// itemBuilder: (context, index){
// return ListTile(title: Text(' Note Title : ${snapshot.data!.docs[index]['Note Title']}'),
//
//
// );
// },
// ) : snapshot.hasError ?
// Text('Error is happened')
//     :
// CircularProgressIndicator();
//
// },
// )
// ,
//
// Center
// (
// child: Column
// (
// children: [
// ElevatedButton
// (
// onPressed: () {firestore.collection('notes').add({'title': 'Note', 'des' : 'kkk'});},
// child: Text
// ('send'),)
// ],
// ),
// ),
//
// FutureBuilder<dynamic>
// (
// //future: db.once(),
//
// builder: (
// context,
//
// AsyncSnapshot snapshot
// ){
// if(snapshot.connectionState == ConnectionState.waiting){
// return Center(child: CircularProgressIndicator());
// }
// if(snapshot.hasData){
// final notes = snapshot.data!.snapshot;
// return ListView.builder(
// itemCount: notes.length,
// itemBuilder: (BuildContext context, i)=> Container(
// height: 100,
// width: 100,
// child: Card(
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// child: Column(
// children: [
// Text(notes.children.toList()[i].child('title').value),
// Text(notes.children.toList()[i].child('des').value)
// ],
//
// ),
// ),
// ),
// );
// }
// return const Center(child: Text('There is something wrong!'),);
// },
// )
// StreamBuilder<QuerySnapshot>
// (
// stream: db.collection('
// notes')
// .
// snapshots
// (
// ),builder: (
// context, snapshot) {
// if (!snapshot.hasData) {
// return Center(
// child: CircularProgressIndicator(),
// );
// } else
// return ListView(
// children: snapshot.data!.docs.map((doc) {
// var index;
// return ListTile(title: Text(' Note Title : ${snapshot.data!.docs[index]['Note Title']}'),
// );}).toList(),
// );
// },
// )
// ,
//
//
// // class RunApp extends StatelessWidget {
// //   const RunApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: FirstScreen(),
// //     );
// //   }
// //
// // }
// //
// // class FirstScreen extends StatefulWidget {
// //   const FirstScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<FirstScreen> createState() => _FirstScreenState();
// // }
// //
// // class _FirstScreenState extends State<FirstScreen> {
// //   final firestore = FirebaseFirestore.instance;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Firebase',)),
// //       body: Center(
// //         child: Column(
// //           children: [
// //             ElevatedButton(
// //               onPressed: () {
// //                 firestore.collection('notes').add({'Note Description': 'flutter course by IT Sharks', 'Note Title' : 'Stalk Camp'});
// //
// //                 final note= Note(
// //                   title: controllerTitle.text,
// //                   description:controllerDescription.text,
// //                 );
// //                 createNote(note);
// //                 Navigator.pop(context);
// //               },
// //               child: Text('send'),)
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // onPressed: () {firestore.collection('notes').add({'Note Description': 'flutter course by IT Sharks', 'Note Title' : 'Stalk Camp'});
// //
// // final note= Note(
// // title: controllerTitle.text,
// // description:controllerDescription.text,
// // );
// // createNote(note);
// // Navigator.pop(context);
// // }
// //
// // body: StreamBuilder<QuerySnapshot>(
// // stream: db.collection('notes').snapshots(),
// // builder: (context, snapshot) {
// // if (!snapshot.hasData) {
// // return Center(
// // child: CircularProgressIndicator(),
// // );
// // } else
// // return ListView(
// // children: snapshot.data!.docs.map((doc) {
// // return ListTile(title: Text(' Note Title : ${snapshot.data!.docs[index]['Note Title']}'),
// // );}).toList(),
// // );
// // },
// // )
// // ,
