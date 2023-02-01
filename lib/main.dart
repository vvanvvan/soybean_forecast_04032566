import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'interface',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'interface'),

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
  late AnimationController _controller;
  final List<String> items = [
    'มกราคม 2566',
    'กุมภาพันธ์ 2566',
    'มีนาคม 2566',
  ];
  String? selectedValue;


  void _fetchData(BuildContext context, [bool mounted = true]) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('รอสักครู่',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.mitr(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0),
                    ),)
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await Future.delayed(const Duration(seconds: 3));

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

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
                            'ทำนายราคากากถั่วเหลืองล่วงหน้า',
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
                      height: 355, //335
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
                                      width: 260,
                                      child: Expanded(
                                        child: Text('ราคากากถั่วเหลืองของสหรัฐอเมริกา ',style: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18.0),
                                         ),
                                        ),
                                      ),
                                    ),
                                  SizedBox(width: 5.0,),
                                  SizedBox(
                                  width: 150.0,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: 'กรอกตัวเลข',
                                          filled: true,
                                          fillColor: Colors.grey.shade50,
                                        ),
                                      ),
                                    ),
                                  SizedBox(width: 15.0,),
                                  Expanded(
                                    child: Text('ดอลลาร์สหรัฐ/ตัน',style: GoogleFonts.mitr(
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
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                              child: Row(
                                children: [
                              Container(
                                width: 170,
                                child: Expanded(
                                   child: Text('ราคาน้ำมันดิบ ',style: GoogleFonts.mitr(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0),
                                    ),
                                   ),
                                ),
                              ),
                                  SizedBox(width: 95.0,),
                                  SizedBox(
                                    width: 150.0,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'กรอกตัวเลข',
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.0,),
                                  Expanded(
                                    child: Text('ดอลลาร์สหรัฐ/บาร์เรล',style: GoogleFonts.mitr(
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
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                 Container(
                                   width: 230,
                                   child: Expanded(
                                     child: Text('เลือกเดือนที่ต้องการทำนายผล ',style: GoogleFonts.mitr(
                                       textStyle: TextStyle(
                                           color: Colors.black87,
                                           fontSize: 18.0),
                                     ),),
                                   ),
                                 ),
                                  SizedBox(width: 35.0,),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    decoration: BoxDecoration(color: Colors.grey.shade50,),
                                    width: 150,
                                    child: DropdownButton(
                                      value: items[0],
                                      items: items.map((country){
                                        return DropdownMenuItem(
                                          child: Text(country),
                                          value: country,
                                        );
                                      }).toList(),
                                      onChanged: (country){
                                        print("You selected: $country");
                                        setState(() {
                                          // index =
                                        });
                                      },
                                    ),
                                  ),
                                ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
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
                                        width: 120,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                // textStyle: TextStyle(fontSize: 20),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                ),
                                            ),
                                            onPressed: () => _fetchData(context),
                                            child: Text("ทำนาย" ,style: GoogleFonts.mitr(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0),
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
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ผลลัพธ์การทำนายราคากากถั่วเหลืองนำเข้าไทย',style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0),
                            ),
                            ),
                            SizedBox(width: 94.0,),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: SizedBox(
                                  width: 200.0,
                                  child: TextField(
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: ' ',
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text('บาท/กิโลกรัม',textAlign : TextAlign.center, style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0),
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
    );
  }
}




