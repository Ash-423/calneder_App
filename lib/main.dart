
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
  print("mainnn ");
  runApp( MyApp());
}

double goodWidth(wP , wL ,{height = 0 , width = 0 } ){
  if(height == 0) height = Sheight ;
  if (width == 0 )  width = Swidth  ;
  //if(Platform. )

  var res = portrait? width*wP : width*wL ;
  return res ;
}

double goodHeight(hP , hL ,{height = 0 , width = 0 } ){
  if(height == 0) height = Sheight ;
  if (width == 0 )  width = Swidth  ;
  print("pro " + portrait.toString());
  print("width " + Swidth.toString());
  // print("pro " + portrait.toString());
  var res = portrait? height*hP : height*hL ;
  print("res" + res.toString() );
  return res ;
}

double iconsize(wP , wL ,{height = 0 , width = 0 } ){
  if(height == 0) height = Sheight ;
  if (width == 0 )  width = Swidth  ;
  var res = portrait? width*wP : width*wL ;
  return res ;
}

//static int s = 99 ;
class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool firsttime = true ;
  // This widget is the root of your application.
  StatefulWidget dir = mainpage();

  @override
  Widget build(BuildContext context) {
    if(firsttime){
      StatelessWidget dir = FirstTimePage() ;
      //firsttime = false ;
    }
    else {StatefulWidget dir = mainpage();}
    return MaterialApp(
      title: 'calender',
      theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(182, 219, 255, 1.2),primary:Color.fromRGBO(153, 204, 255, 1),onPrimaryContainer:Color.fromRGBO(0, 0, 0, 1.0) ,onTertiary: Color.fromRGBO(153, 204, 255, 0.5) ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromRGBO(123, 189, 255, 1)
            //color: Theme.of(context).colorScheme.onTertiary),
          )),
      initialRoute: '/FirstTimePage',
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
  void printlog(con){
    print("i am here ");
    Navigator.pushNamed(con, '/NewCalnder');
  }
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
                      onPressed: (){ printlog(context);},
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
  void printlog(con , entered ){
    print("i am here NewCalnder" + entered);
    //Navigator.pushNamed(con, '/mainpage');
  }


  List<bool> _validate = List.generate(3, (index) => false);
  List<TextEditingController> myController = List.generate(3, (i) => TextEditingController());

  void submit(con){
    validate(con) ;
    bool good = true ;
    for (bool val in _validate ){
      if(!val){
        good = false ;
        break;}
    }
    if (good) {
      int i = 0 ;
      for(TextEditingController controller in myController){
        values[i] = controller.text ;
        i++;}
        Navigator.pushNamed(con, '/mainpage');

      }

  }
  @override
  void dispose() {
    for (TextEditingController controller in myController)
      controller.dispose();
    super.dispose();
  }
  void validate(con){
    //myController[i].text.isEmpty ? _validate[i] = true : _validate[i] = false;
    int i = 0 ;
    for(TextEditingController controller in myController){
      controller.text.isEmpty ? _validate[i] = false : _validate[i] = true ;
      print("pteto " + i.toString() + _validate[i].toString());
      i++; }
    //Navigator.pushNamed(con, '/mainpage');
  }

  bool wrote= false ;
  //Color c = Color.fromRGBO(153, 204, 255, 1.0);
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
              //SizedBox(height : goodHeight(0.03, 0.2)),
              Text("Calender Name " ,style: TextStyle(fontSize : fontsize(context, 0.035  ,0.025)  ) ),

               SizedBox(

                   //alignment: Alignment.bottomRight,
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
                  print("cnameeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                  Cname = text ;
                  return null;
                },
              )),
              Text("Start Date " ,style: TextStyle(fontSize : fontsize(context, 0.035  ,0.025)  ) ),
              SizedBox(
              //alignment: Alignment.bottomRight,
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
                      //DateTime.now() - not to allow to choose before today.
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
                //alignment: Alignment.bottomRight,
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
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2030),
                      );  if(EDate != null ){
                        setState(() {
                          myController[2].text = SDate.toString().substring(0,10); //set foratted date to TextField value.
                        });
                      }else{
                        print("Date is not selected");
                      }} ),),
              // SizedBox(width : 390),
              /*SizedBox(
                height : goodHeight(0.08, 0.08),
                width: goodWidth(0.5, 0.5),
                child : TextField(
                  maxLength: 25,
                  controller: myController[0],
                  decoration: InputDecoration(
                      errorText: _validate[0] ? ' Value Cant Be Empty' : null,
                      labelText:  'Enter the Value' ),
                  //onTapOutside : (value){print("on complete edit");}
                ),),*/
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


    /*Center(
            child : Column(
              //mainAxisAlignment : MainAxisAlignment.center ,
                children : <Widget>[
                  SizedBox(height : goodHeight(0.3, 0.2)),
                  Text("Calender Name " ,style: TextStyle(fontSize : fontsize(context, 0.035  ,0.045)  ) ),
                 // SizedBox(width : 390),
                  SizedBox(
                    height : goodHeight(0.08, 0.08),
                    width: goodWidth(0.5, 0.5),
                    child : TextField(
                        maxLength: 25,
                        controller: myController[0],
                        decoration: InputDecoration(
                            errorText: _validate[0] ? ' Value Cant Be Empty' : null,
                            labelText:  'Enter the Value' ),
                        //onTapOutside : (value){print("on complete edit");}
                    ),),
                  // calender name
                  SizedBox(height : 20),


                  Text("start from " ,style: TextStyle(fontSize : 18),),
                  // SizedBox(width : 70),
                  SizedBox(
                    height : 55,
                    width: 250,
                    child : TextField(
                      //key: Key('SDate'),
                      controller: myController[1], //editing controller of this TextField
                      decoration: const InputDecoration(
                        //icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter start Date" //label text of field
                      ),
                      readOnly: true,  // when true user cannot edit text
                      Time(2101)
                        );onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: Date
                        if(pickedDate != null ){


                          setState(() {

                            myController[1].text = pickedDate.toString(); //set foratted date to TextField value.
                          });
                        }else{
                          print("Date is not selected");
                        }
                      },),
                  ), //
                  SizedBox(height : 20),

                  Text("ends at " ,style: TextStyle(fontSize : 18),),
                  //SizedBox(width : 70),
                  SizedBox(
                    height : 55,
                    width: 250,
                    child : TextField(
                      //key: Key('SDate'),
                      controller: myController[2], //editing controller of this TextField
                      decoration: const InputDecoration(
                        //icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter end date " //label text of field
                      ),
                      readOnly: true,  // when true user cannot edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101)
                        );
                        if(pickedDate != null ){
                          setState(() {
                            myController[2].text = pickedDate.toString(); //set foratted date to TextField value.
                          });
                        }else{
                          print("Date is not selected");
                        }
                      },),
                  ), //

                  SizedBox(height : 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        //validate(0);
                        //validate();
                        submit(context);

                      });
                    },
                    child: Text('create'),
                  )

                ])));*/
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
    print("main page");
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
    print("bulid once ");
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
          // Center(
          //   child: Text("It's cloudy here"),
          // ),
          schedule(),
          Center(
            child: Text(displayHeight(context).toString()),
          ),
        ],
      ),
    );
  }
}
double fontsize(BuildContext context , xp , xl  ){
  double res =  portrait ? xp : xl ;
  return displayWidth(context) * res ;}

class weeklycalnder extends StatelessWidget {
  @override
  //static double Swidth = 0  , Sheight  = 0;
  //static bool portrait = true ;
  final String title = Cname;

  Widget build(BuildContext context) {
    pagename = "weekly calender" ;
    Swidth =  kIsWeb ? 700 : MediaQuery.of(context).size.width;
    Sheight = kIsWeb ? 1000 :  MediaQuery.of(context).size.height;
    portrait = Swidth<Sheight ? true : false  ;
    print (portrait) ;
    return SingleChildScrollView(
        child:  Container(
          //SizedBox(width: 100 , height : 20  ),
          color: Theme.of(context).colorScheme.onTertiary,

          child :
          Center( child : Column (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              rows(context) )),

          /*Column(

              //mainAxisAlignment: MainAxisAlignment.center ,
               children: <Widget> [
            Expanded( child : Row(// titels and week days

                        children: <Widget> [
                            Text("  days  \n week#    "),Text("  Sun    "),Text("  Mon    "),Text("  The    "), Text("   Wed   "), Text("   Thu     ") , Text("  Fri    ") , Text("  Sat")
                                           ]
                    )),
                 SizedBox(width: 100 , height : 20  ),
                 Row(// titels and week days
                     children: <Widget> [
                       Text("  days  \n week#    "),Text("  Sun    "),Text("  Mon    "),Text("  The    "), Text("   Wed   "), Text("   Thu     ") , Text("  Fri    ") , Text("  Sat")
                     ]
                 ),

                                  ],
        )*/

        ));
  }


  //double  h = 0.2 * displayHeight ;
  Widget aday(BuildContext context , text , width,height ){
    return Column(
      children: <Widget >[
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              Text(text , style: TextStyle(fontSize : fontsize(context,0.021,0.021) ,height:0.75, backgroundColor:  Theme.of(context).colorScheme.primary) , textAlign : TextAlign.left,) ,
              SizedBox(width :goodWidth(0.25, 0.25,width: width)),
              GestureDetector( onTap: () {print("add"); }, child: Icon(Icons.add_box_outlined , size : goodWidth(0.25, 0.28,width: width) ) )

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
          //color: Color.fromRGBO(160,220 , 220 + (i*5) , 1) ,
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
          //color: Color.fromRGBO(160,220 , 220 + (i*5) , 1) ,
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
        //color: Color.fromRGBO(160,220 , 220 + (i*5) , 1) ,
        child : aday(context , "99-99\n99-99" ,  goodWidth(0.128, 0.128) ,goodHeight(0.1, 0.2),)//Center (child : Text(text , style: TextStyle(fontSize : fontsize(context,0.04) )))
    );}  // one day block



  List<Widget> rows(BuildContext context){ // bulid all the rows
    print("hello rows " + Sheight.toString()) ;
    int weeksnumber = 30 ;
    //double fontsize = displayWidth(context) * 0.04;

    List<Widget> rows = [
      Text( Cname + " calender"  , style: TextStyle(fontSize : fontsize(context,0.05,0.05) ), textAlign: TextAlign.right,),
      SizedBox( height : (Sheight*0.03)  ),
      Row(// titels and week days
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            SizedBox( width : (Swidth *0.009)  ),
            block(context,0),block(context,2 ,text : "Sun"),block(context,2 ,text : "Mon"),block(context,2 ,text : "The"), block(context,2 ,text : "Wed"),block(context,2 ,text : "Thu"), block(context,2 ,text : "Fri") , block(context,2 ,text : "Sat")
          ]  )];

    for (var i = 1; i < weeksnumber; i++) {
      rows.add(Row(// titels and week days
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [  SizedBox( width : (displayHeight(context ) *0.009)  ),
            block(context,1,i: i ),block(context,3),block(context,3),block(context,3), block(context,3),block(context,3) , block(context,3), block(context,3) ]
      ));
    }


    return rows;
    //print("hi ");
  }}

class schedule  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  print("hi");
  pagename = "schedule";
  return SingleChildScrollView(
      child:  Container(
  child : Text("hi ")));
  }

}
Size displaySize(BuildContext context) {
  //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  //debugPrint('Height = ' + displaySize(context).height.toString());
  return Sheight;
}

double displayWidth(BuildContext context) {
  //debugPrint('Width = ' + displaySize(context).width.toString());
  return  Swidth;
}

/*
class _MyHomePageState extends State<mainpage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Text(widget.title),
        bottom : const TabBar(
          dividerColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              text: 'Flights',
              icon: Icon(Icons.flight),
            ),],),




      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }*/

