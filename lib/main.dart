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

class _CalculatorState extends State<Calculator>{

    Widget calcbutton(String btntxt, Color btncolor, Color txtcolor){
      return Container(
            child: ElevatedButton(
              onPressed: () {
                calculation(btntxt);
              },
              child: Text('$btntxt',
                style: TextStyle(
                  fontSize: 35,
                  color: txtcolor,
                ),
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                  backgroundColor: MaterialStatePropertyAll<Color>(btncolor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(color: btncolor)
                      )
                  )
              )
            ),
      );
    }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('AC',Colors.grey,Colors.black),
                calcbutton('+/-',Colors.grey,Colors.black),
                calcbutton('%',Colors.grey,Colors.black),
                calcbutton('/',Colors.orange,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7',Colors.white12,Colors.white),
                calcbutton('8',Colors.white12,Colors.white),
                calcbutton('9',Colors.white12,Colors.white),
                calcbutton('x',Colors.orange,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4',Colors.white12,Colors.white),
                calcbutton('5',Colors.white12,Colors.white),
                calcbutton('6',Colors.white12,Colors.white),
                calcbutton('-',Colors.orange,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1',Colors.white12,Colors.white),
                calcbutton('2',Colors.white12,Colors.white),
                calcbutton('3',Colors.white12,Colors.white),
                calcbutton('+',Colors.orange,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text('0',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(34, 20, 128, 20)),
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.white12),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: Colors.white12)
                            )
                        )
                    )
                ),
                calcbutton('.', Colors.white12, Colors.black),
                calcbutton('=', Colors.orange, Colors.black),
              ],
            )
          ],
        ),
      ),
    );
  }
    //Calculator logic
    dynamic text ='0';
    double numOne = 0;
    double numTwo = 0;

    dynamic result = '';
    dynamic finalResult = '';
    dynamic opr = '';
    dynamic preOpr = '';
    void calculation(btnText) {


      if(btnText  == 'AC') {
        text ='0';
        numOne = 0;
        numTwo = 0;
        result = '';
        finalResult = '0';
        opr = '';
        preOpr = '';

      } else if( opr == '=' && btnText == '=') {

        if(preOpr == '+') {
          finalResult = add();
        } else if( preOpr == '-') {
          finalResult = sub();
        } else if( preOpr == 'x') {
          finalResult = mul();
        } else if( preOpr == '/') {
          finalResult = div();
        }

      } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

        if(numOne == 0) {
          numOne = double.parse(result);
        } else {
          numTwo = double.parse(result);
        }

        if(opr == '+') {
          finalResult = add();
        } else if( opr == '-') {
          finalResult = sub();
        } else if( opr == 'x') {
          finalResult = mul();
        } else if( opr == '/') {
          finalResult = div();
        }
        preOpr = opr;
        opr = btnText;
        result = '';
      }
      else if(btnText == '%') {
        result = numOne / 100;
        finalResult = doesContainDecimal(result);
      } else if(btnText == '.') {
        if(!result.toString().contains('.')) {
          result = result.toString()+'.';
        }
        finalResult = result;
      }

      else if(btnText == '+/-') {
        result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
        finalResult = result;

      }

      else {
        result = result + btnText;
        finalResult = result;
      }


      setState(() {
        text = finalResult;
      });

    }


    String add() {
      result = (numOne + numTwo).toString();
      numOne = double.parse(result);
      return doesContainDecimal(result);
    }

    String sub() {
      result = (numOne - numTwo).toString();
      numOne = double.parse(result);
      return doesContainDecimal(result);
    }
    String mul() {
      result = (numOne * numTwo).toString();
      numOne = double.parse(result);
      return doesContainDecimal(result);
    }
    String div() {
      result = (numOne / numTwo).toString();
      numOne = double.parse(result);
      return doesContainDecimal(result);
    }


    String doesContainDecimal(dynamic result) {

      if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
          return result = splitDecimal[0].toString();
      }
      return result;
    }
}
