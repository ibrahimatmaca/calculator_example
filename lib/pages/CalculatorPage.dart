import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _data = "";
  String _oldOperation = "";

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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: _upTextColumn(),
            ),
            Expanded(
              child: _gridViewBuilder(),
            ),
          ],
        ),
      ),
    );
  }

// TODO: Here is the field to be inspected when the calculator's buttons are clicked.
  _upTextColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height/6,
          alignment: Alignment.centerLeft,
          child: Text(
            _oldOperation,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white38, fontSize: 36),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height/9,
          alignment: Alignment.centerRight,
          child: Text(
            _data,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 56),
          ),
        ),
      ],
    );
  }

  // TODO: Here we created our grids with gridview and created buttons.
  GridView _gridViewBuilder() {
    return GridView.builder(
        padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        physics: NeverScrollableScrollPhysics(),
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
    else if (_index == 2 || _index % 4 == 3)
      return Colors.orange;
    else
      return Colors.white24;
  }

  stateChangeData(int _index) {
    if (_index >= 2) {
      if (_data == "" || _data == "0")
        _data = items[_index];
      else if ("=" == items[_index]) //Equals
        equalsData();
      else {
        _data = _data + items[_index];
        _oldOperation = _data;
      }
    } else if (_index == 0 && _data.length != 0) {
      // C
      deleteChar();
    } else if (_index == 1) {
      //AC
      _data = "";
      _oldOperation = "";
    }
  }

  deleteChar() {
    _data = _data.substring(0, _data.length - 1);
    _oldOperation = _oldOperation.substring(0, _oldOperation.length - 1);
  }

// Equals function
  equalsData() {
    Parser _parse = Parser();
    Expression _exp = _parse.parse(_data);
    ContextModel cm = ContextModel();
    _data = '${_exp.evaluate(EvaluationType.REAL, cm)}';
  }
}
