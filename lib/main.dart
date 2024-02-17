import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
//variables
  double firstnum = 0.0;
  double secondnum = 0.0;
  var display = '0';
  double result = 0.0;
  double output = 0.0;
  var operation = '';
  bool cleared = false;

  onButtonClick(value) {
    if (value == 'AC') {
      result = 0.0;
      display = '0';
      firstnum = 0.0;
      secondnum = 0.0;
      operation = '';
    }
    // else if (value == '=') {
    // }

    else if (value == 'x' ||
        value == '/' ||
        value == '+' ||
        value == '-' ||
        value == '=') {
      operation = value == '=' ? operation : value;
      operation.replaceAll('x', '*');
      cleared = true;
      if (firstnum == 0.0) {
        firstnum = double.parse(display);
        print("ff" + firstnum.toString());
      } else if (secondnum == 0.0) {
        secondnum = double.parse(display);
        print("ss" + secondnum.toString());
      }

      if (value == '=' || (firstnum != 0.0 && secondnum != 0.0)) {
        if (firstnum != 0.0 && secondnum != 0.0) {
          print("inside1" + firstnum.toString());
          print("inside2" + secondnum.toString());
        }

        if (value != '=' && result != 0) {
          firstnum = result;
          secondnum = double.parse(display);
          if (firstnum != 0.0 && secondnum != 0.0) {
            print("inside12" + firstnum.toString());
            print("inside22" + secondnum.toString());
          }
        }

        print("heree");
        print(firstnum);
        print(secondnum);
        print(operation);

        if ((firstnum != 0.0 && secondnum != 0.0)) {
          print("inside13 " + firstnum.toString());
          print("inside23 " + secondnum.toString());

          if (operation == '+')
            result = firstnum + secondnum;
          else if (operation == '-')
            result = firstnum - secondnum;
          else if (operation == '*')
            result = firstnum * secondnum;
          else if (operation == '/') result = firstnum / secondnum;
          display = result.toString();
          firstnum = result;
          secondnum = 0.0;
          result = 0.0;
          print("r " + result.toString());
          print("s" + secondnum.toString());
          print("f" + firstnum.toString());
        }
      }
    }

    // if (firstnum != 0.0 && secondnum != 0.0) {
    //   firstnum = result;
    //   secondnum = double.parse(display);
    //   if (operation == '+')
    //     result = firstnum + secondnum;
    //   else if (operation == '-')
    //     result = firstnum - secondnum;
    //   else if (operation == '*')
    //     result = firstnum * secondnum;
    //   else if (operation == '/') result = firstnum / secondnum;
    //   display = result.toString();
    //   print(result);
    // }
    else {
      // initial = '';
      if (display.startsWith('0') && display.length > 1) {
        display = display.substring(1);
      }
      if (cleared == true) {
        display = '';
        cleared = false;
      }

      display = display + value;
      print(result);
    }
    // if (operation == '+') {
    //   result = (firstnum + secondnum).toString();
    // } else if (operation == '-') {
    //   result = (firstnum - secondnum).toString();
    // } else if (operation == '*') {
    //   result = (firstnum * secondnum).toString();
    // } else if (operation == '/') {
    //   result = (firstnum / secondnum).toString();
    // }
    print(value);

    // setState(() {
    //   result;
    // });
    setState(() {
      display;
    });
  }

  Widget calcButton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: MaterialButton(
        onPressed: () {
          onButtonClick(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children:
                // const [
                //   Text("Hello", style: TextStyle(fontSize: 40, color: Colors.white))
                // ],
                [
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(display,
                      style: TextStyle(color: Colors.white, fontSize: 80)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcButton('AC', Colors.grey, Colors.black),
                      calcButton('+/-', Colors.grey, Colors.black),
                      calcButton('%', Colors.grey, Colors.black),
                      calcButton('/', Colors.amber, Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcButton(
                          "7", Color.fromARGB(56, 158, 158, 158), Colors.white),
                      calcButton("8", const Color.fromARGB(56, 158, 158, 158),
                          Colors.white),
                      calcButton("9", const Color.fromARGB(56, 158, 158, 158),
                          Colors.white),
                      calcButton("x", Colors.amber, Colors.white)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcButton(
                          "4", Color.fromARGB(56, 158, 158, 158), Colors.white),
                      calcButton("5", const Color.fromARGB(56, 158, 158, 158),
                          Colors.white),
                      calcButton("6", const Color.fromARGB(56, 158, 158, 158),
                          Colors.white),
                      calcButton("-", Colors.amber, Colors.white)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcButton(
                          "1", Color.fromARGB(56, 158, 158, 158), Colors.white),
                      calcButton("2", const Color.fromARGB(56, 158, 158, 158),
                          Colors.white),
                      calcButton("3", const Color.fromARGB(56, 158, 158, 158),
                          Colors.white),
                      calcButton("+", Colors.amber, Colors.white)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          onButtonClick('0');
                        },
                        child: Text('0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            )),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                          // Adjust styling as needed
                          backgroundColor:
                              const Color.fromARGB(56, 158, 158, 158),
                        ),
                      ),
                      // calcButton(
                      //     "0", Color.fromARGB(56, 158, 158, 158), Colors.white),
                      calcButton(".", const Color.fromARGB(56, 158, 158, 158),
                          Colors.white),
                      calcButton("=", const Color.fromARGB(56, 158, 158, 158),
                          Colors.white),
                    ],
                  ),
                ],
              )
            ]));
  }
}
