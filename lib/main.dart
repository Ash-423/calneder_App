
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
//import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'DataBase.dart';
//import 'package:intl/intl_browser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

double Swidth = 0  , Sheight  = 0;
bool portrait = true ;
String pagename = "weekly calnderrrr" ;
String Cname = "" ;
DateTime SDate =DateTime(2003) , EDate=DateTime(2003)  ;
DateTime? SDatepick ,  EDatepick;
bool ftime = false   ;

  List studentsList = [];
  final CollectionReference collectionRef =
  FirebaseFirestore.instance.collection("Calenders");
  final CollectionReference collectionRefEvents =
  FirebaseFirestore.instance.collection("Events");
//Stream<DocumentSnapshot> snapshot =  Firestore.instance.collection("listofprods").document('ac1').snapshots();

  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef.get().then((querySnapshot) {
        print(11111);
        bool o = true ;

        for (var result in querySnapshot.docs) {
          if(o){
          studentsList.add(result.data());
          print("heheheh " + result.get("Cname"));
          o = false ; }
        }
      });

      return studentsList;
    } catch (e) {
      debugPrint("Error - $e");
      return e;
    }
  }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //bool cc = await isEmpty("Calenders");
  //print ("hhhhhhhhhhh" + cc.toString());
  print("program started ");
  runApp( MyApp());
}

double goodWidth(wP , wL ,{height = 0 , width = 0 } ){
  if(height == 0) height = Sheight ;
  if (width == 0 )  width = Swidth  ;

  var res = portrait? width*wP : width*wL ;
  return res ;
}

double goodHeight(hP , hL ,{height = 0 , width = 0 } ){
  if(height == 0) height = Sheight ;
  if (width == 0 )  width = Swidth  ;
  var res = portrait? height*hP : height*hL ;
  return res ;
}

double iconsize(wP , wL ,{height = 0 , width = 0 } ){
  if(height == 0) height = Sheight ;
  if (width == 0 )  width = Swidth  ;
  var res = portrait? width*wP : width*wL ;
  return res ;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Future<bool> isFirsttime() async {
     ftime = await isEmpty("Calenders");
   // print("ftime " + ftime.toString());
    return ftime ;
  }
  // This widget is the root of your application.
/*Future<void> readC() async {
print("readc");
// Assuming you have a collection called "users" and a document with ID "user1"

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Calenders').get();

  if (querySnapshot.docs.isNotEmpty) {
    querySnapshot.docs.forEach((doc) {
      // Document data is available in doc.data() Map
      print('Document data: ${doc.data()}');
    });
  } else {
    print('No documents found in the collection.');
  }
// Get the document

}*/

  @override
  Widget build(BuildContext context)  {
    //bool ft = true ;
    print("before fun ");
    //isFirsttime();
    print ( ftime) ;
    print("after fun ");
    return MaterialApp(
      title: 'calender',
      theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(182, 219, 255, 1.2),primary:Color.fromRGBO(153, 204, 255, 1),onPrimaryContainer:Color.fromRGBO(0, 0, 0, 1.0) ,onTertiary: Color.fromRGBO(153, 204, 255, 0.5) ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromRGBO(123, 189, 255, 1)
            //color: Theme.of(context).colorScheme.onTertiary),
          )),
      initialRoute:  ftime  ? '/FirstTimePage' : '/mainpage' ,
      routes: {
        '/FirstTimePage': (context) => const FirstTimePage(),
        '/NewCalnder': (context) => const NewCalnder(),
        '/mainpage': (context) =>  mainpage(),
        '/AList': (context) =>  AList(),
        //'/third': (context) => const ThirdRoute(),
      },
      // home: FirstTimePage(),
    );
  }
}
class FirstTimePage extends StatelessWidget {
  const FirstTimePage({super.key});
  final String title = "welcome to calender";
  @override
  Widget build(BuildContext context) {
    Swidth =  kIsWeb ? 700 : MediaQuery.of(context).size.width;
    Sheight = kIsWeb ? 1000 :  MediaQuery.of(context).size.height;
    portrait = Swidth<Sheight ? true : false  ;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title : Text(title ,style: TextStyle(fontSize :fontsize(context,0.045 , 0.035) ))),

        //foregroundColor: Colors.deepPurpleAccent,
        body :  Center(
            child :
            Column(mainAxisAlignment: MainAxisAlignment.center,
                children : <Widget>[
                  Text("you dont have any calender yet " , style: TextStyle(fontSize :fontsize(context,0.045 , 0.035) ) ),
                  SizedBox (height : goodHeight(0.03, 0.03),),
                  SizedBox(
                    width: goodWidth(0.3, 0.3),
                    height : goodHeight(0.035, 0.08),
                    child :  FloatingActionButton(
                      onPressed: (){ Navigator.pushNamed(context, '/NewCalnder');},
                      child:  Text("start a calender" , style: TextStyle(fontSize : fontsize(context, 0.035 , 0.03) )),
                    ),)]

            )));
  }
}

class NewCalnder extends StatefulWidget {
  const NewCalnder({super.key});

  @override
  State<NewCalnder> createState() => NewCalnderState();
}

class NewCalnderState extends State<NewCalnder>{
  //NewCalnderState({super.key});
  final _formKey = GlobalKey<FormState>();
  final String title = "New Calnder";

  List<TextEditingController> myController = List.generate(3, (i) => TextEditingController());

  @override
  void dispose() {
    for (TextEditingController controller in myController)
      controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Swidth =  kIsWeb ? 700 : MediaQuery.of(context).size.width;
    Sheight = kIsWeb ? 1000 :  MediaQuery.of(context).size.height;
    portrait = Swidth<Sheight ? true : false  ;
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme,
          title : Text(title),),

      body :  Form(
          key: _formKey,
          child: Center (child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Calender Name " ,style: TextStyle(fontSize : fontsize(context, 0.035  ,0.025)  ) ),

               SizedBox(
                height : goodHeight(0.08, 0.1),
                width: goodWidth(0.5, 0.45),
                child :
              TextFormField(
                controller: myController[0],
                   maxLength : 15 ,
                  decoration: InputDecoration(
                    hintText: 'calender name',),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'calender name  cant be empty';
                  }
                  Cname = text ;
                  return null;
                },
              )),
              Text("Start Date " ,style: TextStyle(fontSize : fontsize(context, 0.035  ,0.025)  ) ),
              SizedBox(
              height : goodHeight(0.08, 0.1),
              width: goodWidth(0.5, 0.45),
              child :
              TextFormField(
                controller: myController[1] ,
                  decoration: InputDecoration(
                    hintText: 'Start date ',),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'start date cant be empty';
                    }
                    return null;
                  },
                onTap: () async {
                       SDatepick = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      //get today's date
                      firstDate: DateTime(DateTime.now().year),
                      lastDate: DateTime(2030),
                  );  if(SDatepick != null ){
                    setState(() {
                      myController[1].text = SDatepick.toString().substring(0,10); //set foratted date to TextField value.
                   SDate = SDatepick! ;
                    });
                  }else{
                    print("Date is not selected");
                  }} ),),

              Text("End Date " ,style: TextStyle(fontSize : fontsize(context, 0.035  ,0.025)  ) ),
              SizedBox(

                height : goodHeight(0.08, 0.1),
                width: goodWidth(0.5, 0.45),
                child :
                TextFormField(
                    controller: myController[2] ,
                    decoration: InputDecoration(
                      hintText: 'End date ',),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'End date cant be empty';
                      }
                      return null;
                    },
                    onTap: () async {
                     EDatepick = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        //get today's date
                        firstDate: DateTime(SDate!.year ,SDatepick!.month , SDatepick!.day ),
                        lastDate: DateTime( DateTime.now().year + 1),
                      );  if(EDatepick != null ){
                        setState(() {
                          myController[2].text = EDatepick.toString().substring(0,10); //set foratted date to TextField value.
                          EDate = EDatepick! ;
                        });
                      }else{

                      }} ),),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //var c =  calenders( Cid : 0 ,Cname: Cname, Sdate: SDate.toString().substring(0,10), Edate: EDate.toString().substring(0,10));
                    //insertcalenders(c);

                    var c = Calenders(0,Cname, Timestamp.fromDate(SDate!), Timestamp.fromDate(EDate!));
                    c.addcalender();
                    Navigator.pushNamed(context, '/mainpage');
                  }
                },
                child: Text('Submit' ,style: TextStyle(fontSize : fontsize(context, 0.035  ,0.030)  ) ),
              )
            ],
          ),
          )),
    );

  }
}


class mainpage extends StatefulWidget {
  const mainpage({super.key});
  @override
  State<mainpage> createState() => mainpageState();
}
class mainpageState extends State<mainpage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print(" start mainpage ");
    return Scaffold(
      appBar: AppBar(

        title:  Text( pagename , style: TextStyle(fontSize : fontsize(context,0.045,0.045) ) ,  ),
        actions: [
          IconButton(
            icon:  Icon(Icons.settings ,size: goodWidth(0.058, 0.04) ),
            tooltip: 'setting',
            onPressed: () {
              NewCalnder();
            },
          ),
        ],
          bottom:  TabBar(
          controller: _tabController,
          tabs:  <Widget>[
          Tab(
          icon: Icon(Icons.calendar_today_rounded ,size: goodWidth(0.058, 0.04),),
          ),
          Tab(
          icon: Icon(Icons.calendar_month_outlined , size: goodWidth(0.058, 0.04)),
          ),
          Tab(
          icon: Icon(Icons.check_circle_outline_sharp ,size: goodWidth(0.058, 0.04)),
          ),
          Tab(
           icon: Icon(Icons.menu_book_sharp ,size: goodWidth(0.058, 0.04)),
            )
          ],
          ),
            //bottomNavigationBar :
      ),


      body: TabBarView(
        controller: _tabController,
        children: [
          weeklycalnder(),
          Center(
          child: Text("schedule skippoooo" , style: TextStyle( fontSize: 30 ),) ) ,
          TodoLists(),
          Subjects() ,


        ],
      ),
    );
  }
}
double fontsize(BuildContext context , xp , xl  ){
  double res =  portrait ? xp : xl ;
  return Swidth * res ;}
String title = "";



bool isTask = false ;
List<String> types = <String>['Homework', 'midterm','quiz','final','due date','other'];
String typepick = 'other';
class weeklycalnder extends StatefulWidget {
  const weeklycalnder({super.key});
  @override
  State<weeklycalnder> createState() => weeklycalnderState();
}
class weeklycalnderState extends State<weeklycalnder> {
//class weeklycalnder extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();


  List<TextEditingController> myController = List.generate(
      3, (i) => TextEditingController());

 /* @override
  void dispose() {
    for (TextEditingController controller in myController)
      controller.dispose();
    super.dispose();
  }*/

//class weeklycalnder extends StatelessWidget {
  @override
  Future<void> setTitle() async {
    String t = await getString("Calenders", "Cname");
    title = t;
    print("title is " + title);
  }

  Widget build(BuildContext context) {
    pagename = "weekly calender";
    setTitle();
    Swidth = kIsWeb ? 700 : MediaQuery
        .of(context)
        .size
        .width;
    Sheight = kIsWeb ? 1000 : MediaQuery
        .of(context)
        .size
        .height;
    portrait = Swidth < Sheight ? true : false;
    return SingleChildScrollView(
        child: Container(
          //height: goodHeight(1, 1),
          //color: Theme.of(context).colorScheme.onTertiary,

            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Calenders")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Events")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (snapshot.hasError||snapshot2.hasError) {
                    print("error");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting ||snapshot2.connectionState == ConnectionState.waiting ) {
                    print("waiting");
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // If there is no data in the collection, you can show a message
                  if (snapshot.data!.docs.isEmpty && snapshot2.data!.docs.isEmpty) {
                    print("empty");
                    return Center(
                      child: Text('No data available'),
                    );
                  }
                  //String cn = "cn";
                  snapshot.data?.docs.forEach((DocumentSnapshot document) {
                    Cname = document.get("Cname");
                    SDate = document.get("Sdate").toDate();
                    EDate = document.get("Edate").toDate();
                    print("ptatai " + Cname);
                  });
                  docevents = [] ;
                  doceventsrefs = [] ;
                  snapshot2.data?.docs.forEach((DocumentSnapshot document) {
                    docevents.add(document);
                    doceventsrefs.add(document.id);
                    //doceventsrefs.add(document)
                  });
                  return
                    Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                        rows(context)));
                });})));
  }
  List<DocumentSnapshot> docevents = [] ;
  List<String> doceventsrefs = [] ;
  Widget aday(BuildContext context,DateTime date, day, month, width, height) {
   // print("docevnt nummmm ${docevents.length}");
    List<Widget> chil = [Row(
        children:[
    Text(day.toString() + "-" + month.toString(), style: TextStyle(
        fontSize: fontsize(context, 0.021, 0.021),
        height: 0.75,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary), textAlign: TextAlign.left,),
      SizedBox(width: goodWidth(0.25, 0.25, width: width)),
      GestureDetector(onTap: () {
        Adayevent(context , Edate1  : date);
      },
          child: Icon(Icons.add_box_outlined,
              size: goodWidth(0.25, 0.28, width: width)))
    ]),];
   // print("before  ${chil.length} ");
   // print(chil);
   chil.addAll(dayEvents(date));
    //print("after  ${chil.length} ");
    //print(chil);
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: chil

    //dayEvents()


    );
  }

  List<Widget> dayEvents(DateTime Ddate){
    List<Widget> events = [] ;
    docevents.forEach((element) {
      //print(Ddate.toString());
      //print(element.get('Edate').toDate().toString());
      if(samedate(Ddate, element.get('Edate').toDate())){
       events.add(eventBlock(element));

      }
    });

   // print("eve numssss  ${events.length} " );
    return events ;
  }
  Widget eventBlock(DocumentSnapshot<Object?> ele ){//['Homework', 'midterm','quiz','final','due date','other']
    var color = Color.fromRGBO(118, 118, 118, 1.0) ;
    switch (ele.get('type')) {
      case "due date" : color = Color.fromRGBO(250, 240, 204, 1.0) ; break;
      case "Homework" : color = Color.fromRGBO(232, 188, 173, 1.0) ; break;
      case "midterm" : color = Color.fromRGBO(188, 226, 253, 1.0) ; break;
      case "quiz" : color = Color.fromRGBO(217, 188, 253, 1.0) ; break;
      case "final" : color = Color.fromRGBO(188, 253, 203, 1.0) ; break;
      default : color = Color.fromRGBO(197, 197, 197, 1.0) ;
    }
   return GestureDetector(
     child : Container(
        width : goodWidth(0.9, 0.9 ,width: goodWidth(0.128, 0.128)),
        height: goodHeight(0.15, 0.15,height: goodHeight(0.1, 0.25),),
        margin: EdgeInsets.all(3) ,
        decoration: BoxDecoration(
            color: color ,
            borderRadius :BorderRadius.circular(4)
        ),
        child : Text(ele.get('Ename') , textAlign: TextAlign.center,)
    ),
   onDoubleTap: (){

   showDialog(
       context: context,
       builder: (context) {
         return StatefulBuilder( // StatefulBuilder
           builder: (context, setState) {
             return AlertDialog(
               title: Text(ele.get('Ename')),
               content:Container(
               alignment: Alignment.center,
                 child :Column(
                   children: [
                     Text("Event Name :  ${ele.get('Ename')}" , style: TextStyle(fontSize: fontsize(context, 0.03, 0.03)),textAlign: TextAlign.left,),
                     Text("Event Dis :  ${ele.get('Edis')}" ,style: TextStyle(fontSize: fontsize(context, 0.03, 0.03)),textAlign: TextAlign.left),
                     Text("Event Date :  ${ele.get('Edate').toDate().toString().substring(0,10)}",style: TextStyle(fontSize: fontsize(context, 0.03, 0.03)),textAlign: TextAlign.left)
                     ,Text("Event type :  ${ele.get('type')}",style: TextStyle(fontSize: fontsize(context, 0.03, 0.03)),textAlign: TextAlign.left),
                   ],
                 ), //Text("This is a sample alert dialog."),
                 width:goodWidth(0.55, 0.5), // 80% of the screen width
                 height: goodHeight(0.13, 0.1),
               ),
               actions: [
                 TextButton(
                   onPressed: () {

                       collectionRefEvents.doc(ele.id).delete() ;
                       Navigator.of(context).pop();
                       print("delete ");


                     }
             ,
                   child: Text("delete"),
                 ),
                 TextButton(
                   onPressed: () {
                     Navigator.of(context).pop();
                   },
                   child: Text("Close"),
                 )
               ],
             );
           },
         );});
    print ("deltee");  },
   );
  }
  
  void delete(String text , DateTime date){
    
  } 
 late String Ename ;
  late String Edis ;
  late DateTime Evdate = DateTime(2003) ;
  late bool istask  = false;
  late String type ;
  void Adayevent(BuildContext context , {DateTime? Edate1 }) {
    Evdate = Edate1 == null ? DateTime.now() : Evdate ;
    //dayEvents(Evdate);
    //print("evdate " + Evdate.toString());
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder( // StatefulBuilder
          builder: (context, setState) {
        return AlertDialog(
          title: Text("add event "),
          content:Container(
          child : addeventForm(context, setState) , //Text("This is a sample alert dialog."),
          width:goodWidth(0.55, 0.5), // 80% of the screen width
          height: goodHeight(0.3, 0.1),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  print("add ");
                  var e = Events(0, 0, Ename, Edis, Timestamp.fromDate(Evdate), istask, "subject", type);
                  e.addEvent();
                   for (TextEditingController controller in myController ){controller.clear()  ;}
                  istask = false ;
                  type = "other";


                }
              },
              child: Text("add"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                for (TextEditingController controller in myController ){controller.clear()  ;}
                istask = false ;
                type = "other";

              },
              child: Text("Close"),
            )
          ],
        );
      },
    );});
  }

Widget addeventForm(context, StateSetter setState , ){
//myController[2].text = Evdate.toString().substring(0,10) ;
   @override
  void dispose() {
    for (TextEditingController controller in myController)
      controller.dispose();
    context.dispose();
  }

  return  Form(
      key: _formKey,
      child: Center (child : Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: [
            Text("event Name :" ,style: TextStyle(fontSize : fontsize(context, 0.025  ,0.03)  ) ),

            SizedBox(
                height : goodHeight(0.04, 0.1),
                width: goodWidth(0.4, 0.45),
                child :
                TextFormField(
                  controller: myController[0],
                  maxLength : 15 ,
                  decoration: InputDecoration(
                 //   hintText: 'event name',
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'event name  cant be empty';
                    }
                    Ename = text ;
                   // Cname = text ;
                    return null;
                  },
                )),],
        ),
        Row(
          children: [
            Text("discrpation :" ,style: TextStyle(fontSize : fontsize(context, 0.025  ,0.03)  ) ),

            SizedBox(
                height : goodHeight(0.04, 0.1),
                width: goodWidth(0.4, 0.45),
                child :
                TextFormField(
                  controller: myController[1],
                  //maxLength : 15 ,
                  decoration: InputDecoration(
                    //hintText: 'event name'
                    ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'discretion  cant be empty';
                    }
                    Edis = text ;
                    return null;
                  },
                )),],
        ),
        Row(
          children: [
            Text("event Date :" ,style: TextStyle(fontSize : fontsize(context, 0.025  ,0.03)  ) ),

            SizedBox(
                height : goodHeight(0.04, 0.1),
                width: goodWidth(0.4, 0.45),
                child :
                TextFormField(
                  controller: myController[2],
                 // initialValue: "3-3",
                  //maxLength : 15 ,
                  decoration: InputDecoration(
                  //  hintText: 'event name',
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'date  cant be empty';
                    }
                    Cname = text ;
                    return null;
                  },
                    onTap: () async {
                      SDatepick = await showDatePicker(
                        context: context,
                        initialDate: SDate ,
                        //get today's date
                        firstDate: SDate,
                        lastDate: EDate,
                      );
                      if(SDatepick != null ){
                        setState(() {
                          myController[2].text = SDatepick.toString().substring(0,10); //set foratted date to TextField value.
                          Evdate = SDatepick!;
                        });
                      }else{
                        print("Date is not selected");
                      }}
                )),],
        ),
        Row(
          children: [
            Text("event task :" ,style: TextStyle(fontSize : fontsize(context, 0.025  ,0.03)  ) ),

            SizedBox(
                height : goodHeight(0.04, 0.1),
                width: goodWidth(0.4, 0.45),
                child :
                CheckboxListTile(
                  value: istask,
                  onChanged: (bool? newValue) {
                    setState(() {
                      istask = newValue! ;
                      print("newwww" + newValue.toString());
                      istask = newValue!;
                      //Adayevent(context);
                    });
                  },
                ),)],
        ),
        Row(
          children: [
            Text("event type :" ,style: TextStyle(fontSize : fontsize(context, 0.025  ,0.03)  ) ),

            SizedBox(
              height : goodHeight(0.04, 0.1),
              width: goodWidth(0.4, 0.45),
              child :
              DropdownButton<String>(
                value: typepick,
                elevation: 16,
               // style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                 // color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  print("changed value1111");

                  setState(() {
                    type = value! ;
                    print("changed value");
                    typepick = value!;
                  });
                },
                items: types.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ))],
        ),
    ])));

/*void updateDate(){
  var limit
  DateTime limit = EDate
*/
}


  Widget block(BuildContext context, int type, { text = "", int ii = 0, Sdate = 0}) {

    if (type == 0) {
      return Container(
        width: goodWidth(0.075, 0.070),
        height: goodHeight(0.04, 0.04),
      );
    } // empty block

    if (type == 1) {
      double f = (i > 9) ? 0.0539 : 0.06;
      return Container( //week number
          alignment: Alignment.center,
          width: goodWidth(0.075, 0.075),
          height: goodHeight(0.1, 0.2),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)))
          ),
          child: Text(
            ii.toString(), style: TextStyle(fontSize: fontsize(context, f, f)),
            textAlign: TextAlign.left,))
      ;
    } //number of weeks

    if (type == 2) { // week days
      return Container(
          width: goodWidth(0.128, 0.128),
          height: goodHeight(0.04, 0.1),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)))
          ),

          child: Center(child: Text(
              text, style: TextStyle(fontSize: fontsize(context, 0.04, 0.04))))
      );
    } // week days blocks
    dtrack = dtrack.add(Duration(days: 1));
 print("dtrackkk" + dtrack.toString());
    return Container(
        width: goodWidth(0.128, 0.128),
        //day block
        height: goodHeight(0.1, 0.25),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(0, 0, 0, 1))
        ),
        child: aday(context,dtrack ,dtrack.day.toString(),
          dtrack.month.toString() /*+ "\n99-99"*/, goodWidth(0.128, 0.128),
          goodHeight(0.1,
              0.2),) //Center (child : Text(text , style: TextStyle(fontSize : fontsize(context,0.04) )))
    );
  } // one day block
  late DateTime dtrack ;
  void setdates() {
    int? days = EDate.difference(SDate).inDays + 2;
    // int? differenceInMilliseconds = EDate?.difference(SDate!).inMilliseconds;
    int weeks = (days / 7).ceil();
    bool flag = true ;
    while(SDate?.weekday != 7){
      print(SDate.weekday.toString() + "sdateeeeee : " + SDate.toString());
    if (flag ){  weeks + 1; flag = false ;  }
    SDate = SDate.subtract(Duration(days: 1));
    }
    //SDate = SDate.subtract(Duration());
    //weeks = EDate?.weekday != 6 ? weeks : weeks + 1;
    while(EDate?.weekday != 6){
      print(EDate.weekday.toString() + "eeedateeeeee : " + EDate.toString());
      if (flag ){  weeks + 1; flag = false ;  }
      EDate = EDate.add(Duration(days: 1));
    }
   // return weeks;
     dtrack = SDate; //.subtract(Duration(days: SDate.weekday));

  }

  //var lim = SDate.weekday == 7 ? 0 : 1;
  var i = 0 ;
  bool samedate(DateTime t , DateTime e){
   bool res = t.year == e.year &&
       t.month == e.month &&
       t.day == e.day;
   print(res);
    return res;
  }
  List<Widget> rows(BuildContext context) {
    // bulid all the rows
    setdates();
    //setTitle();document

    List<Widget> rows = [
      SizedBox(height: (Sheight * 0.008)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
      Text(Cname + " calender",
        style: TextStyle(fontSize: fontsize(context, 0.05, 0.05)),
        textAlign: TextAlign.right,),
    SizedBox(
    child :  FloatingActionButton(
    onPressed: (){ Adayevent(context);},
    child : Icon(Icons.add , size : 55 ),
    ),),] ),

      SizedBox(height: (Sheight * 0.03)),
      Row( // titels and week days
          children: <Widget>[
            SizedBox(width: (Swidth * 0.009)),
            block(context, 0),
            block(context, 2, text: "Sun"),
            block(context, 2, text: "Mon"),
            block(context, 2, text: "The"),
            block(context, 2, text: "Wed"),
            block(context, 2, text: "Thu"),
            block(context, 2, text: "Fri"),
            block(context, 2, text: "Sat")
          ])
    ];


    //dtrack = SDate!.subtract(Duration(days: SDate.weekday + lim));

    //print("limta" + SDate?.weekday.toString());
   //bool rrr = samedate(dtrack.subtract(Duration(days: 1)), EDate);
    var ii = 1;
    while(! samedate(dtrack.subtract(Duration(days: 1)), EDate)) {
     // print("in while  " + samedate(dtrack.subtract(Duration(days: 1)), EDate).toString());
      //print(dtrack.subtract(Duration(days: 1)).toString() + "still looping " + EDate.toString());
      rows.add(Row( // titels and week days
          children: <Widget>[
            SizedBox(width: Sheight * 0.009),
            block(context, 1, ii : ii),
            block(context, 3),
            block(context, 3),
            block(context, 3),
            block(context, 3),
            block(context, 3),
            block(context, 3),
            block(context, 3)
          ]
      ));
    ii = ii +1 ; }

    /* rows.add( FloatingActionButton.large(
      onPressed: (){},
      child: Icon(Icons.add , size : 70 ),
    ));*/

    return rows ;
  } //}
//}


}


String Listtitle = "To Do list ";
String Stitle = "To Do list ";
class TodoLists extends StatelessWidget {
  @override
  final String title = "todolist ";

  bool isnolists = false ;

  Widget build(BuildContext context) {
    pagename = "To Do list ";
    Swidth = kIsWeb ? 700 : MediaQuery.of(context).size.width;
    Sheight = kIsWeb ? 1000 : MediaQuery.of(context).size.height;
    portrait = Swidth < Sheight ? true : false;
    return SingleChildScrollView(
        child: Container(
          height: Sheight - 130 ,
          color: Theme
              .of(context)
              .colorScheme
              .onTertiary,

          child: isnolists ? nolists(context) : Llists(context,) ,

        ));
  }

  Widget nolists(BuildContext context){


    List<Widget> w = [  Center(
        child :
        Column(mainAxisAlignment: MainAxisAlignment.center,
            children : <Widget>[
              Text("you dont have any to do lists yet " , style: TextStyle(fontSize :fontsize(context,0.045 , 0.035) ) ),
              SizedBox (height : goodHeight(0.03, 0.03),),
              SizedBox(
                //width: goodWidth(0.3, 0.3),
                //height : goodHeight(0.035, 0.08),
                child :  FloatingActionButton(
                  onPressed: (){ Navigator.pushNamed(context, '/NewCalnder');},
                  child : Icon(Icons.add , size : 55 ),

                ),)]

        )) ];

    return  Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: w ));

  }

  Widget Llists(BuildContext context) {
    List<Widget> lists = [Text("TO Do Lists  " , textAlign: TextAlign.left,style: TextStyle(fontSize: goodWidth(0.04, 0.04))) ,
      SizedBox(height: goodHeight(0.03, 0.3),)] ;
    var Lname = "list  " ;
    for(int i = 0 ; i < 4;i++){
    lists.add(listblocks(context , Lname + i.toString()));
    lists.add(SizedBox(height: goodHeight(0.02, 0.02)));}
    lists.add(FloatingActionButton(
      onPressed: (){ },
      child : Icon(Icons.add , size : 55 ),));
    return   Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: lists );

  }
  Widget listblocks(BuildContext context ,String Lname){
    return GestureDetector(
        onTap: (){
          print("pressed");
        Listtitle = Lname;
          Navigator.pushNamed(context, '/AList');
    },
    child:Container(
      decoration: BoxDecoration(color : Color.fromRGBO(87, 162, 234, 1.0), borderRadius: BorderRadius.circular(20)),
      width: Swidth-30,
      height: 50,

      child: Text(Lname , textAlign: TextAlign.center,style: TextStyle(fontSize: goodWidth(0.04, 0.04)),),
    ));

  }
}
class AList extends StatefulWidget {
  const AList({super.key});

  @override
  State<AList> createState() => AListState();
}

class AListState extends State<AList> {
  @override

 // AList(String t){this.title = t ; }
  Map<String, bool> values = {
    'foo': false,
    'bar': false,
    'pteto' : false
  };

  Widget build(BuildContext context) {
    print("bulid ");
    return Scaffold(
        appBar: AppBar(
            title: Text(Listtitle ,style : TextStyle(fontSize : fontsize(context,0.045,0.045) )  )
        ),
        body:tasks(),
        floatingActionButton: FloatingActionButton.large(
          onPressed: (){},
          child: Icon(Icons.add , size : 70 ),
        ),



    );
  }

  ListView tasks(){
    return ListView(
      children: values.keys.map((String key) {
        return  CheckboxListTile(
          title:  Text(key, style : TextStyle(fontSize : fontsize(context,0.035,0.035) ) ),
          value: values[key],
          onChanged: (bool? value) {
            setState(() {
              values[key] = value!;
              List<MapEntry<String, bool>> w = values.entries.toList();
              w.sort((a, b) => a.value ? 1 : -1);
              values = Map.fromEntries(w);
            }
            );
          },
        );
      }//return SizedBox() ; }
      ).toList(),
    );
  }
}


class Subjects extends StatelessWidget {
  @override
  final String title = "Subjects ";

  bool isnoSubjects = false ;

  Widget build(BuildContext context) {
      pagename = "To Do list ";
      Swidth = kIsWeb ? 700 : MediaQuery.of(context).size.width;
      Sheight = kIsWeb ? 1000 : MediaQuery.of(context).size.height;
      portrait = Swidth < Sheight ? true : false;
      return SingleChildScrollView(
          child: Container(
            height: Sheight - 130 ,
            color: Theme
                .of(context)
                .colorScheme
                .onTertiary,

            child: isnoSubjects ? noSubjects(context) : LSubjects(context,) ,

          ));

  }

  noSubjects(BuildContext context) {

    List<Widget> w = [  Center(
        child :
        Column(mainAxisAlignment: MainAxisAlignment.center,
            children : <Widget>[
              Text("you dont have any Subjects yet " , style: TextStyle(fontSize :fontsize(context,0.045 , 0.035) ) ),
              SizedBox (height : goodHeight(0.03, 0.03),),
              SizedBox(
                //width: goodWidth(0.3, 0.3),
                //height : goodHeight(0.035, 0.08),
                child :  FloatingActionButton(
                  onPressed: (){ Navigator.pushNamed(context, '/NewCalnder');},
                  child : Icon(Icons.add , size : 55 ),

                ),)]

        )) ];

    return  Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: w ));

  }
  LSubjects(BuildContext context) {
   return Column(
       children : [Text("subject : "),  SizedBox(height: goodHeight(0.05, 0.05)) , Row(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [   subjectblocks(context , "math "),subjectblocks(context , "swe "),]
   ),
     SizedBox(height: goodHeight(0.05, 0.05),)    ,Row(
   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [   subjectblocks(context , "math "),subjectblocks(context , "swe "),]
    )]);


  }
  Widget subjectblocks(BuildContext context ,String Sname){
    return GestureDetector(
        onTap: (){
          print("pressed");
          Stitle = Sname;
          Navigator.pushNamed(context, '/AList');
        },
        child:Container(
          decoration: BoxDecoration(color : Color.fromRGBO(87, 162, 234, 1.0), borderRadius: BorderRadius.circular(20)),
          width: goodWidth(0.3, 0.1),
          height: goodHeight(0.2, 0.2),

          child: Text(Sname , textAlign: TextAlign.center,style: TextStyle(fontSize: goodWidth(0.04, 0.04)),),
        ));

  }
}





