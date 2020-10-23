import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _data = "";

  List<String> items = [
    'C',
    'AC',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '6',
    '5',
    '4',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    ' ',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  _data,
                  style: TextStyle(color: Colors.white, fontSize: 56),
                )),
          ),
          Expanded(
            flex: 2,
            child: _gridViewBuilder(),
          ),
        ],
      ),
    );
  }

  // TODO: Burada gridview ile gridlerimizi yaratarak butonlar oluşturduk
  GridView _gridViewBuilder() {
    return GridView.builder(
        padding: EdgeInsets.only(left: 15,right: 5,top: 5,bottom: 5),
        itemCount: items.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.transparent,
            child: MaterialButton(
              splashColor: Colors.greenAccent,
              color: _colorSelect(index),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45)),
              onPressed: () {
                setState(() {
                  stateChangeData(index);
                });
              },
              child: Text(
                items[index],
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          );
        });
  }

  Color _colorSelect(int _index) {
    if (_index < 2)
      return Colors.grey;
    else if (_index == 2 ||
        _index % 4 == 3)
      return Colors.orange;
    else
      return Colors.white24;
  }

  stateChangeData(int _index) {
    if (_index >= 2) {
      if (_data == "" || _data == "0")
        _data = items[_index];
      else if (_index == items.length - 1) //Equals
        equalsData();
      else
        _data = _data + items[_index];
    } else if (_index == 0 && _data.length != 0) {
      // C
      deleteChar();
    } else if (_index == 1) {
      //AC
      _data = "";
    }
  }

  deleteChar() {
    _data = _data.substring(0, _data.length - 1);
  }

  equalsData() { // Equals function
    Parser _parse = Parser();
    Expression _exp = _parse.parse(_data);
    ContextModel cm = ContextModel();
    _data = '${_exp.evaluate(EvaluationType.REAL, cm)}';
  }


}


