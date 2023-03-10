import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soybean_forecast/main.dart';
import 'API.dart';
import 'dart:convert';


class TrainPage extends StatelessWidget {
  const TrainPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'train interface',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.amber.shade300,
      ),
      home: const MyHomePage(title: 'train interface'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  var validdrop = Text ("โปรดเลือกเดือน",
    // overflow: TextOverflow.fade,
    style:GoogleFonts.mitr(
      textStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0),
    ),
  );
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _text1 = TextEditingController();  //textediting
  final _text2 = TextEditingController();// controller
  bool _validate1 = false;
  bool _validate2= false;//variable to store the bool value
  bool _validate3= false;

  String? _chosenValue;
  int index=0;
  String? selectedValue;
  String url='';
  String year='';
  var Data;
  String QueryText = '';


  String valueMonth='';
  String valueYear='';
  String valueThai='';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print( _selectedIndex);
      if( _selectedIndex == 0){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
      }else if( _selectedIndex == 1){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrainPage()));
      }
    });
  }
  void dispose1() {
    _text1.dispose();
    super.dispose();
  }
  void dispose2() {
    _text2.dispose();
    super.dispose();
  }
  void showDialogUpdate(BuildContext context) async {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
        Text(
            "ส่งค่าสำเร็จ",
            style: GoogleFonts.mitr(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0),
            ),
            textAlign: TextAlign.center

        ),
        content: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 300, height: 200,
                child: Image.asset('asset/images/check-correct.gif', height: 10,)),
          ],
        ),
        actions: [
          TextButton(
            child: Text("ตกลง",  style: GoogleFonts.mitr(
              textStyle: TextStyle(
                  color: Colors.green,
                  fontSize: 22.0),
            ),),
            onPressed: () => Navigator.pop(context),
          ),
        ],

      ),
    );

  }


  void showDialogTrain(BuildContext context) async {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(

        title:
        Text(
            "รอสักครู่",
            style: GoogleFonts.mitr(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0),
            ),
            textAlign: TextAlign.center

        ),
        content: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 300,
              height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                      image: AssetImage('asset/images/cupertino_activity.gif'),
                      fit: BoxFit.cover
                  ),
            ),
            child: Text(
              "กำลังเทรนโมเดล กรุณารอสักครู่",
              style: GoogleFonts.mitr(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0),
              ),
            ),

          ),

          ]
        ),
        actions: [
          TextButton(
            child: Text("ตกลง",  style: GoogleFonts.mitr(
              textStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0),
            ),),
            onPressed: () => Navigator.pop(context),
          ),
        ],

      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    var now = new DateTime.now();
    var MONTHS = ["มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม"];

    final List<String> items = [];
    String formattedDateTime(int num) {
      DateTime now = new DateTime.now();
      var years = now.year+543;
      return MONTHS[now.month+num]+" "+years.toString();
    }

    String formattedDateOver(int num) {
      int count = now.year+543;
      // var new_year = new DateTime(2567, num);
      var year = count+1;
      // print("เดือน $num");
      //print(MONTHS[num]);
      return MONTHS[num-1]+" "+year.toString();
    }



    int count = now.month;
    int countYear = 1;
    var count_month=12;

    for(int i=0;i<count_month;++i) {
      count++;
      // print(count);

      if(count > 12){
        items.add(formattedDateOver(countYear));
        // print(countYear);
        countYear++;
      }else{
        items.add(formattedDateTime(i));

      }
    }
    return Scaffold(
      // appBar: AppBar(
      // title: Text('Soybean Forecast'),
      // ),
      backgroundColor: Color.fromRGBO(255, 194, 0, 0.15),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Image.asset('asset/images/logo.png',
                          fit: BoxFit.fill,
                          height: 55,
                        ),
                        Expanded(
                          child: Text(
                            'เพิ่มข้อมูลราคากากถั่วเหลืองนำเข้าไทย',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 25.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.amber.shade300,
                      boxShadow: [new BoxShadow(blurRadius: 3.0)],
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              // alignment: Alignment.center,
                              height: 200,
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage('asset/images/banner2.png'),
                                      fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:  Container(
                    alignment: Alignment.bottomCenter,
                    width: 685,
                    height: 306,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade300,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:35.0, left:35.0, right: 35.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                                children: [
                                  Container(
                                    width: 230,
                                    child: Text('เลือกเดือนที่ต้องการเพิ่มข้อมูล ',style: GoogleFonts.mitr(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0),
                                    ),
                                    ),
                                  ),
                                  SizedBox(width: 100.0,), //35
                                  SizedBox(
                                    // decoration: BoxDecoration(color: Colors.grey.shade50,),
                                    height: 70,
                                    width: 150.0,
                                    child: Form(
                                      key: _formKey,
                                      child: DropdownButtonFormField(
                                        isExpanded: true,
                                        isDense: true,
                                        // focusColor:Colors.white,
                                        style: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                            // overflow: TextOverflow.ellipsis,
                                              color: Colors.black,
                                              fontSize: 18.0),
                                        ),
                                        value: _chosenValue,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        // isDense: true,
                                        items: items.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text (value,
                                              // overflow: TextOverflow.fade,
                                              style:GoogleFonts.mitr(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            _validate3 = true;
                                            return "โปรดเลือกเดือน";
                                          }else{
                                            _validate3 = false;
                                          }
                                          return null;
                                        },
                                        hint:Text(
                                          "เลือกเดือน",
                                          style: GoogleFonts.mitr(
                                            textStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        onChanged: (String? value) {

                                          final splitted = value?.split(' ');
                                          print(splitted![0]);
                                          switch(splitted[0]){
                                            case "มกราคม" : {valueMonth='1'; valueYear=splitted[1];} break;
                                            case "กุมภาพันธ์" : {valueMonth='2'; valueYear=splitted[1];}break;
                                            case "มีนาคม" : {valueMonth='3'; valueYear=splitted[1];} break;
                                            case "เมษายน" : {valueMonth='4'; valueYear=splitted[1];} break;
                                            case "พฤษภาคม" : {valueMonth='5'; valueYear=splitted[1];} break;
                                            case "มิถุนายน" : {valueMonth='6'; valueYear=splitted[1];} break;
                                            case "กรกฎาคม" : {valueMonth='7'; valueYear=splitted[1];} break;
                                            case "สิงหาคม" : {valueMonth='8'; valueYear=splitted[1];} break;
                                            case "กันยายน" : {valueMonth='9'; valueYear=splitted[1];} break;
                                            case "ตุลาคม" :{valueMonth='10'; valueYear=splitted[1];} break;
                                            case "พฤศจิกายน" : {valueMonth='11'; valueYear=splitted[1];} break;
                                            case "ธันวาคม" : {valueMonth='12'; valueYear=splitted[1];} break;
                                          }
                                          print(' month $valueMonth and year $valueYear');
                                          setState(() {
                                            _chosenValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8, right:8, top: 22), //horizontal: 8.0, vertical: 22
                            child: Row(
                              children: [
                                Container(
                                  width: 250,
                                  child: Expanded(
                                    child: Text('กรอกราคากากถั่วเหลืองนำเข้าไทย',style: GoogleFonts.mitr(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0),
                                    ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 80.0,),
                                FractionalTranslation(
                                  translation: Offset(0,0),
                                  child: SizedBox(
                                    height: 70,
                                    width: 150.0,
                                    child: TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)')),
                                        FilteringTextInputFormatter.deny(RegExp(r'^0+'), ),],
                                      style: GoogleFonts.mitr(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0),
                                      ),
                                      controller: _text2,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        labelStyle: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15.0),
                                        ),
                                        labelText: 'กรอกตัวเลข',
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        errorText: _validate2 ? 'โปรดกรอกช่องนี้' : null,
                                        // errorStyle: GoogleFonts.mitr(
                                        //   textStyle: TextStyle(
                                        //       color: Colors.red,
                                        //       fontSize: 12.0),
                                        // ),
                                      ),
                                      onChanged: (value) {
                                        valueThai=value;
                                        setState(() {
                                          _text2.text.isEmpty ? _validate2 = true : _validate2 = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.0,),
                                Container(
                                  child: Text('บาท/กิโลกรัม',style: GoogleFonts.mitr(
                                    textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18.0),
                                  ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 17, bottom: 18),
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 50,
                                      width: 160,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          // textStyle: TextStyle(fontSize: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        onPressed: () async {

                                          if(_validate2==false&&_formKey.currentState!.validate()) {
                                            showDialogUpdate(context);
                                          }else{
                                            setState(() {
                                              _text2.text.isEmpty ? _validate2 = true : _validate2= false;
                                            });
                                          }

                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState!.save();
                                          }


                                          url = "http://127.0.0.1:5000/api?New_Month=$valueMonth&Year=$valueYear&priceThai=$valueThai";
                                          print(url);
                                          Data = await Getdata(url);
                                          var DecodedData = jsonDecode(Data);
                                          print('DecodedData $DecodedData');
                                          print('Data $Data');
                                          setState(() {
                                            QueryText = DecodedData.toString();

                                          });

                                          //  Navigator.of(context).pop();
                                        },
                                        child: Text("Update Data" ,style: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 685,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade300,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('กดปุ่มด้านล่างเพื่อเทรนโมเดล',style: GoogleFonts.mitr(
                            textStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0),
                          ),
                          ),
                          SizedBox(width: 94.0,),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 50,
                                      width: 150,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          // textStyle: TextStyle(fontSize: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        onPressed: () async { showDialogTrain(context); },
                                        child: Text("Train Model" ,style: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'ทำนายราคา',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'เทรนโมเดล',
          ),
        ],
        selectedLabelStyle: GoogleFonts.mitr(
          textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0),
        ),
        unselectedLabelStyle:  GoogleFonts.mitr(
          textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18.0),
        ),
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}


