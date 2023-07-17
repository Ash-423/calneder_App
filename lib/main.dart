
import 'package:flutter/material.dart';
//import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
//import 'package:intl/intl_browser.dart';
double Swidth = 0  , Sheight  = 0;
bool portrait = true ;
String pagename = "weekly calnder" ;
String Cname = "" ;
DateTime? SDate  , EDate ;
void main() {
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
  bool firsttime = false ;
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calender',
      theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(182, 219, 255, 1.2),primary:Color.fromRGBO(153, 204, 255, 1),onPrimaryContainer:Color.fromRGBO(0, 0, 0, 1.0) ,onTertiary: Color.fromRGBO(153, 204, 255, 0.5) ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromRGBO(123, 189, 255, 1)
            //color: Theme.of(context).colorScheme.onTertiary),
          )),
      initialRoute: firsttime ? '/FirstTimePage' : '/mainpage' ,
      routes: {
        '/FirstTimePage': (context) => const FirstTimePage(),
        '/NewCalnder': (context) => const NewCalnder(),
        '/mainpage': (context) =>  mainpage(),
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
                          myController[2].text = SDate.toString().substring(0,10); //set foratted date to TextField value.
                        });
                      }else{

                      }} ),),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
    _tabController = TabController(length: 3, vsync: this);
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
          ],
          ),
            //bottomNavigationBar :
      ),


      body: TabBarView(
        controller: _tabController,
        children: [
          weeklycalnder(),
          schedule(),
          Center(
            child: Text(Sheight.toString()),
          ),
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


    return rows;
  }}

class schedule  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("bulid schedule");
  pagename = "schedule";
  return SingleChildScrollView(
      child:  Container(
  child : Text("hi ")));
  }

}





