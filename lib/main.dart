import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final List<String> items = [
    'มกราคม 2566',
    'กุมภาพันธ์ 2566',
    'มีนาคม 2566',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Soybean Forecast'),
      // ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 75.0,
              child: Row(
                children: [
                  Image.asset('asset/images/logo.png',
                    fit: BoxFit.contain,
                    height: 55,
                  ),
                  const Text("ทำนายราคากากถั่วเหลืองล่วงหน้า",
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(
                      height: 0,
                      color: Colors.black,
                      fontSize: 25.0,
                    ),

                  ),
                ],
              ),
              decoration: new BoxDecoration(
                color: Colors.amber,
                boxShadow: [new BoxShadow(blurRadius: 3.0)],
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Expanded(
              child: Row(
                children: [
                  Image.asset('asset/images/banner.jpg',
                    fit: BoxFit.fill,
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: 630,
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const Text('ราคากากถั่วเหลืองอเมริกา ',style: TextStyle(
                            // fontFamily: 'Arial',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          ),
                          SizedBox(width: 40.0,),
                          SizedBox(
                          width: 200.0,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'กรอกตัวเลข',
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text('ราคาน้ำมันดิบ ',style: TextStyle(
                            // fontFamily: 'Arial',
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                          SizedBox(width: 125.0,),
                          SizedBox(
                            width: 200.0,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'กรอกตัวเลข',
                                filled: true,
                                fillColor: Colors.grey.shade50,
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
                         const Text('เลือกเดือนที่ต้องการทำนายผล ',style: TextStyle(
                            // fontFamily: 'Arial',
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                          SizedBox(width: 40.0,),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.grey.shade50,),
                            width: 170,
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
                      padding: const EdgeInsets.only(top: 8.0 ,bottom: 30.0),
                      child: Row(
                        children: [
                          SizedBox(width: 455.0,),
                          Container(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    textStyle: TextStyle(fontSize: 16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),),),
                                onPressed: () {},
                                child: const Text("ทำนาย")),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text('ผลลัพธ์การทำนาย ',style: TextStyle(
                            // fontFamily: 'Arial',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          ),
                          SizedBox(width: 94.0,),
                          Container(
                            child: SizedBox(
                              width: 200.0,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: ' ',
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),
                              ),
                            ),
                          ),
                          const Text(' บาท/กิโลกรัม',textAlign : TextAlign.end, style: TextStyle(
                            // fontFamily: 'Arial',
                            fontSize: 18,
                            color: Colors.black,

                          ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),


          ),
        ],
      ),


    );
  }
}
