import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            // Pressing space in the field will now move to the next field.
            SingleActivator(LogicalKeyboardKey.space): NextFocusIntent(),
          },
          child: FocusTraversalGroup(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              onChanged: () {
                Form.of(primaryFocus!.context!)?.save();
              },
              child: Wrap(
                children: List<Widget>.generate(5, (int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(200, 50)),
                      child:  TextFormField(
                        onSaved: (String? value5555) {
                          debugPrint(
                              'Value for field $index saved as "$value5555"');
                        },
                        style: GoogleFonts.mitr(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.mitr(
                            textStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 15.0),
                          ),
                          labelText: listPriceTH.elementAt(index),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          // errorText: _validate1 ? 'โปรดกรอกช่องนี้' : null,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
