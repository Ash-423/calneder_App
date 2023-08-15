
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Calenders {
  late final int Cid ;
  final String Cname ;
  final Timestamp Sdate ;
  final Timestamp Edate ;

  Calenders(this.Cid,this.Cname,this.Sdate,this.Edate);


  CollectionReference calenders =  db.collection('Calenders');

  Future<void> addcalender() {
    // Call the user's CollectionReference to add a new user
    print("well this is the id happy ?" + calenders.id);

    return calenders
        .add({
      'Cid': Cid, // John Doe
      'Cname': Cname, // Stokes and Sons
      'Sdate': Sdate, // 42
      'Edate': Edate
    })
        .then((value) => print("calender Added"))
        .catchError((error) => print("Failed to add calender: $error"));
  }

  Future<String> getCname() async {
    print("pteto 0");
    final docRef = FirebaseFirestore.instance.collection("Calenders").doc("calenders");
    print(docRef);

    try {
      DocumentSnapshot doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      // ...
      print("pteto 1");
      print(data["Cname"]);
      return data["Cname"];
    } catch (e) {
      print("Error getting document: $e");
      return "error";
    }
  }




}
//static Value = "xxx";
Future getValue(String col , String coloum , {num = 0 }) async {
  print("right place ");
  CollectionReference collectionRef = FirebaseFirestore.instance.collection(col);
  try{
    print("tryyyyyyyyy" + num.toString());
    await collectionRef.get().then((querySnapshot) {
      print("tryyyyyyyyy2222");

      if(num == 0 ){
        print("ifffffffffffff");
     for (var result in querySnapshot.docs) {
       //studentsList.add(result.data());
       print("for for for ");
       print("heheheh " + result.data().toString());}
}
    else {
      print("elseeee");
      for (var result in querySnapshot.docs) {
      print("heheheh11 " );}
    }});}
catch (e) {
debugPrint("Error - $e");
print("object");
return e;
}}


Future<String> getString(String coll , String column ) async {
  final CollectionReference collectionRef =
  db.collection(coll);
  var value = "";
  try {
    await collectionRef.get().then((querySnapshot) {
      bool o = true ;
      for (var result in querySnapshot.docs) {
        //if(o){
          value = result.get(column) ;
          print("heheheh " + value);
         // o = false ; }
      }
    });
    return value ;
  } catch (e) {
    debugPrint("Error - $e");
    return e.toString();
  }
}

Future<DateTime> getDate(String coll , String column ) async {
  final CollectionReference collectionRef =
  db.collection(coll);
  DateTime value = DateTime(2003,1,15);
  try {
    await collectionRef.get().then((querySnapshot) {
      bool o = true ;
      for (var result in querySnapshot.docs) {
        //if(o){
        value = result.get(column).toDate() ;
        print("dateeo " + value.toString());
        // o = false ; }
      }
    });
    return value ;
  } catch (e) {
    debugPrint("Error - $e");
    return value;
  }
}
Future<bool> isEmpty(String coll ) async {
  var res = false ;
  final CollectionReference collectionRef = db.collection(coll);
  try {
    await collectionRef.get().then((querySnapshot) {
      bool o = true ;
      print("the " + coll + " col has # " + (querySnapshot.docs.length).toString() );
      res = querySnapshot.docs.length == 0 ;
      return res  ;
    });
return res ;
} catch (e) {
debugPrint("Error - $e");
return false ;
}
}



class Events {
  late final int CID;

  late final int EID;

  final String Ename;

  final String Edis;

  final String subject;

  final String type;

  final bool task;

  final Timestamp Edate;

Events(this.CID,this.EID,this.Ename,this.Edis,this.Edate,this.task,this.subject,this.type);
  CollectionReference events =  db.collection('Events');
  Future<void> addEvent() {
    // Call the user's CollectionReference to add a new user

    return events
        .add({
      'CID': CID, // John Doe
      'EID': EID, // Stokes and Sons
      'Ename': Ename, // 42
      'Edis':Edis,
      'subject': subject, // Stokes and Sons
      'type': type, // 42
      'task':task,
      'Edate':Edate,

    })
        .then((value) => print("event Added"))
        .catchError((error) => print("Failed to add event: $error"));
  }
}
/*import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> datebasee() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(

    join(await getDatabasesPath(), 'calender_database.db'),

    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE calenders(Cid INTEGER PRIMARY KEY, Cname TEXT, Sdate TEXT ,Edate TEXT )',
      );
    },
    version: 1,
  );
  return database ;
}

Future<void> insertcalenders(calenders calneder) async {

  final db = await datebasee();
  await db.insert(
    'calenders', /////////////////////////////// name table
    calneder.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  print(calneder.toString());
}


class calenders {
  final int Cid ;
  final String Cname ;
  final String Sdate ;
  final String Edate ;

  //final DateTime Sdate ;
  //final DateTime Edate ;

  const calenders({required this.Cid,
             required this.Cname,
             required this.Sdate,
             required this.Edate});

  Map<String, dynamic> toMap() {
    return {
      'Cid': Cid,
      'Cname': Cname,
      'Sdate': Sdate,
      'Edate': Edate,
    };
  }
  String toString() {
    return 'calenders{Cid $Cid, Cname: $Cname, Sdate: $Sdate , Edate: $Edate }';
  }

}
*/