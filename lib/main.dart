import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: new Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  double firstnum = 0.0;
  double secondnum = 0.0;
  bool firstVal = false;
  var display = '0';
  double result = 0.0;
  bool secondVal = false;
  var previousOperation = '';
  var operation = '';
  bool cleared = false;
  String expression = '';
  String val1 = '';
  String val2 = '';
  //ContextModel cm = ContextModel();
  //Expression exp = '';
  Parser p = Parser();
  Widget calcButton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: MaterialButton(
        onPressed: () {
          onButtonClick(btntxt);
        },
        child: Center(
          child: Text(
            btntxt,
            style: TextStyle(
              fontSize: 35,
              color: txtcolor,
            ),
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(10.0),
      ),
    );
  }

// end of button
// end of button

  Widget build(BuildContext buildCx) {
    return new Scaffold(
      appBar: null,
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
                    calcButton('AC', const Color(0xffa5a5a5), Colors.black),
                    calcButton('+/-', const Color(0xffa5a5a5), Colors.black),
                    calcButton('%', Colors.grey, Colors.black),
                    calcButton('÷', Colors.amber, Colors.white),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcButton(
                        "7", Color.fromARGB(56, 158, 158, 158), Colors.white),
                    calcButton("8", const Color(0xff333333), Colors.white),
                    calcButton("9", const Color(0xff333333), Colors.white),
                    calcButton("x", Colors.amber, Colors.white)
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcButton(
                        "4", Color.fromARGB(56, 158, 158, 158), Colors.white),
                    calcButton("5", const Color(0xff333333), Colors.white),
                    calcButton("6", const Color(0xff333333), Colors.white),
                    calcButton("-", Colors.amber, Colors.white)
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcButton(
                        "1", Color.fromARGB(56, 158, 158, 158), Colors.white),
                    calcButton("2", const Color(0xff333333), Colors.white),
                    calcButton("3", const Color(0xff333333), Colors.white),
                    calcButton("+", Colors.amber, Colors.white)
                  ],
                ),
                const SizedBox(height: 15),
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
                        padding: EdgeInsets.fromLTRB(34, 10, 128, 10),
                        // Adjust styling as needed
                        backgroundColor: const Color(0xff333333),
                      ),
                    ),
                    // calcButton(
                    //     "0", Color.fromARGB(56, 158, 158, 158), Colors.white),
                    calcButton(".", const Color(0xff333333), Colors.white),
                    calcButton("=", Colors.amber, Colors.white),
                  ],
                ),
              ],
            )
          ]),
    );
  } // end of state class

  onButtonClick(value) {
    // Replace 'x' with '*' and '÷' with '/'
    value = value.replaceAll('x', '*');
    value = value.replaceAll('÷', '/');

    // Store value in val2
    val2 = value;

    // Check if both val1 and val2 are operators
    if ((val1 == '-' ||
            val1 == '+' ||
            val1 == '/' ||
            val1 == '*' ||
            val1 == '=') &&
        (val2 == '-' ||
            val2 == '+' ||
            val2 == '/' ||
            val2 == '*' ||
            val2 == '=')) {
      val1 = value;
      previousOperation = value;
      return;
    }

    if (value == 'AC') {
      // Reset all variables
      result = 0.0;
      display = '0';
      firstnum = 0.0;
      secondnum = 0.0;
      operation = '';
      previousOperation = '';
      secondVal = false;
      firstVal = false;
      expression = '';
    } else if (value == '*' ||
        value == '/' ||
        value == '+' ||
        value == '-' ||
        value == '=') {
      // Handle operator input
      if (previousOperation != '') {
        expression =
            expression.substring(0, expression.length - 1) + previousOperation;
        previousOperation = '';
      }
      operation = value;
      cleared = true;

      if (firstVal == false) {
        firstnum = double.parse(display);
        firstVal = true;
        expression = expression + firstnum.toString() + operation;
      } else if (secondVal == false && display != "") {
        secondnum = double.parse(display);
        expression = expression + secondnum.toString();
        secondVal = true;
      }

      if (secondVal == true && operation != '') {
        if (operation == '+' || operation == '-' || operation == '=') {
          try {
            // Evaluate the expression
            Parser p = Parser();
            ContextModel cm = ContextModel();
            Expression exp = p.parse(expression);
            result = exp.evaluate(EvaluationType.REAL, cm);
            display = result.toString();
            firstnum = result;
            secondnum = 0.0;
            cleared = true;
            secondVal = false;
          } catch (error) {
            display = 'ERROR';
          }

          if (operation != '=') {
            expression = expression + operation;
            operation = '';
          }
        } else if (operation == '*' || operation == '/') {
          expression = expression + operation;
          secondnum = 0.0;
          secondVal = false;
        }
      }
    } else if (value == '%') {
      // Calculate percentage
      expression.replaceFirst(
          display, ((double.parse(display)) / 100).toString());
      display = ((double.parse(display)) / 100).toString();
    } else if (value == '+/-') {
      // Change sign
      expression.replaceFirst(
          display, ((double.parse(display)) * -1).toString());
      display = ((double.parse(display)) * -1).toString();
    } else {
      // Handle number input
      if (display.startsWith('0')) {
        display = display.substring(1);
      }
      if (cleared == true) {
        display = '';
        cleared = false;
      }
      if (value == '.' && display.contains('.')) {
        display = display;
      } else {
        display = display + value;
      }
    }

    // Update val1 and display
    val1 = value;
    setState(() {
      display;
    });
  }
}
