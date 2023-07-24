
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Calenders {
  final int Cid ;
  final String Cname ;
  final Timestamp Sdate ;
  final Timestamp Edate ;

  Calenders(this.Cid,this.Cname,this.Sdate,this.Edate);

  CollectionReference calenders = FirebaseFirestore.instance.collection('Calenders');

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