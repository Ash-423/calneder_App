
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
String pagename = "weekly calnder" ;
String Cname = "" ;
DateTime? SDate  , EDate ;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // FirebaseFirestore firestore = FirebaseFirestore.instance;


  //await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  //);
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
  //bool firsttime = true ;
  Future<bool> isFirstTime() async {
    int CCount = await FirebaseFirestore.instance.collection('Calenders').snapshots().length;
    print( "counnnt "+ CCount.toString() );
    return  CCount > 0 ;

  }
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context)  {
    bool ft = isFirstTime() as bool;
    return MaterialApp(
      title: 'calender',
      theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(182, 219, 255, 1.2),primary:Color.fromRGBO(153, 204, 255, 1),onPrimaryContainer:Color.fromRGBO(0, 0, 0, 1.0) ,onTertiary: Color.fromRGBO(153, 204, 255, 0.5) ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromRGBO(123, 189, 255, 1)
            //color: Theme.of(context).colorScheme.onTertiary),
          )),
      initialRoute:  ft  ? '/FirstTimePage' : '/mainpage' ,
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
var values = ["","",""];
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
                      SDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      //get today's date
                      firstDate: DateTime(DateTime.now().year),
                      lastDate: DateTime(2030),
                  );  if(SDate != null ){
                    setState(() {
                      myController[1].text = SDate.toString().substring(0,10); //set foratted date to TextField value.
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
                      EDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        //get today's date
                        firstDate: DateTime(SDate!.year ,SDate!.month , SDate!.day ),
                        lastDate: DateTime( DateTime.now().year + 1),
                      );  if(EDate != null ){
                        setState(() {
                          myController[2].text = EDate.toString().substring(0,10); //set foratted date to TextField value.
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
  final String title = Cname;

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

class weeklycalnder extends StatelessWidget {
  @override
  final String title = Cname;

  Widget build(BuildContext context) {
    pagename = "weekly calender" ;
    Swidth =  kIsWeb ? 700 : MediaQuery.of(context).size.width;
    Sheight = kIsWeb ? 1000 :  MediaQuery.of(context).size.height;
    portrait = Swidth<Sheight ? true : false  ;
    return SingleChildScrollView(
        child:  Container(

          color: Theme.of(context).colorScheme.onTertiary,

          child :
          Center( child : Column (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              rows(context) )),

        ));
  }

  Widget aday(BuildContext context , text , width,height ){
    return Column(
      children: <Widget >[
        Row(

            children : [
              Text(text , style: TextStyle(fontSize : fontsize(context,0.021,0.021) ,height:0.75, backgroundColor:  Theme.of(context).colorScheme.primary) , textAlign : TextAlign.left,) ,
              SizedBox(width :goodWidth(0.25, 0.25,width: width)),
              GestureDetector( onTap: () {print("add button pressed"); }, child: Icon(Icons.add_box_outlined , size : goodWidth(0.25, 0.28,width: width) ) )

            ])],

    );
  }
  Widget block(BuildContext context, int type  , { text = "" , int i = 0, Sdate = 0}  ){
    if (type == 0 ){
      return Container(
        width :goodWidth(0.075, 0.070) ,
        height :  goodHeight(0.04, 0.04),
      ); } // empty block

    if (type == 1){
      double f = (i >9) ? 0.0539:0.06 ;
      return Container(//week number
          alignment : Alignment.center,
          width : goodWidth(0.075, 0.075) ,
          height : goodHeight(0.1, 0.2) ,
          decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)))
          ),
          child :  Text(i.toString() , style: TextStyle(fontSize : fontsize(context,f , f) ), textAlign: TextAlign.left,))
      ;
    } //number of weeks

    if(type == 2 ) { // week days
      return Container(
          width :goodWidth(0.128, 0.128) ,
          height : goodHeight(0.04, 0.1),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)))
          ),

          child : Center (child : Text(text , style: TextStyle(fontSize : fontsize(context,0.04,0.04) )))
      );
    } // week days blocks

    return Container(
        width : goodWidth(0.128, 0.128) ,//day block
        height : goodHeight(0.1, 0.25),
        alignment : Alignment.topLeft,
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(0,0 , 0  , 1))
        ),

        child : aday(context , "99-99\n99-99" ,  goodWidth(0.128, 0.128) ,goodHeight(0.1, 0.2),)//Center (child : Text(text , style: TextStyle(fontSize : fontsize(context,0.04) )))
    );}  // one day block



  List<Widget> rows(BuildContext context){ // bulid all the rows
    int weeksnumber = 30 ;

    List<Widget> rows = [
      Text( Cname + " calender"  , style: TextStyle(fontSize : fontsize(context,0.05,0.05) ), textAlign: TextAlign.right,),
      SizedBox( height : (Sheight*0.03)  ),
      Row(// titels and week days
          children: <Widget> [
            SizedBox( width : (Swidth *0.009)  ),
            block(context,0),block(context,2 ,text : "Sun"),block(context,2 ,text : "Mon"),block(context,2 ,text : "The"), block(context,2 ,text : "Wed"),block(context,2 ,text : "Thu"), block(context,2 ,text : "Fri") , block(context,2 ,text : "Sat")
          ]  )];

    for (var i = 1; i < weeksnumber; i++) {
      rows.add(Row(// titels and week days
          children: <Widget> [
            SizedBox( width : Sheight *0.009  ),
            block(context,1,i: i ),block(context,3),block(context,3),block(context,3), block(context,3),block(context,3) , block(context,3), block(context,3) ]
      ));
    }

   /* rows.add( FloatingActionButton.large(
      onPressed: (){},
      child: Icon(Icons.add , size : 70 ),
    ));*/
    return rows;
  }}
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





