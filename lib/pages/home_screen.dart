import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/model/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // defoult Value
  String result = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Calculator',
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onHorizontalDragEnd: ((details) {
                _dragtodelete();
              }),
              child: AutoSizeText(
                _forRes(result),
                style: const TextStyle(
                  fontSize: 100,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: _buildButtonGrid(),
            )
          ],
        ),
      ),
    );
  }

  // buttons grid
  Widget _buildButtonGrid() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.zero,
      crossAxisCount: 4,
      itemCount: button.length,
      itemBuilder: (context, index) {
        return MaterialButton(
          padding: button[index].value == '0'
              ? const EdgeInsets.only(right: 100)
              : EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(60),
            ),
          ),
          color: (button[index].value == opr && curNum != '')
              ? Colors.white
              : button[index].bgColor,
          onPressed: () {
            _buttonPress(button[index].value);
          },
          child: Text(
            button[index].value,
            style: TextStyle(
                color: (button[index].value == opr && curNum != '')
                    ? button[index].bgColor
                    : button[index].fgColor,
                fontSize: 40),
          ),
        );
      },
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      staggeredTileBuilder: (index) =>
          StaggeredTile.count(button[index].value == '0' ? 2 : 1, 1),
    );
  }

  // drag to delete
  void _dragtodelete() {
    // ignore: avoid_print
    setState(() {
      if (result.length > 1) {
        result = result.substring(0, result.length - 1);
        curNum = result;
      } else {
        result = '0';
        curNum = '';
      }
    });
  }

  // button press
  String preNum = '';
  String curNum = '';
  String opr = '';
  void _buttonPress(String buttonText) {
    setState(() {
      switch (buttonText) {
        case '+':
        case 'x':
        case '-':
        case '÷':
          if (preNum != '') {
            _calResult();
          } else {
            preNum = curNum;
          }
          curNum = '';
          opr = buttonText;
          break;
        case '+/-':
          curNum = convertStringTODounble(curNum) < 0
              ? curNum.replaceAll('-', '')
              : '-$curNum';
          result = curNum;
          break;
        case '%':
          curNum = (convertStringTODounble(curNum) / 100).toString();
          result = curNum;
          break;
        case '=':
          _calResult();
          // preNum = '';
          // curNum = '';
          break;
        case 'AC':
          _resetCal();
          break;
        default:
          curNum = curNum + buttonText;
          result = curNum;
      }
    });
  }

  void _calResult() {
    double _preNum = convertStringTODounble(preNum);
    double _curNum = convertStringTODounble(curNum);
    switch (opr) {
      case '+':
        _preNum = _preNum + _curNum;
        break;
      case '-':
        _preNum = _preNum - _curNum;
        break;
      case 'x':
        _preNum = _preNum * _curNum;
        break;
      case '÷':
        _preNum = _preNum / _curNum;
        break;
      default:
        break;
    }

    curNum = (_preNum % 1 == 0 ? _preNum.toInt() : _preNum).toString();
    result = curNum;
  }

  void _resetCal() {
    result = '';
    preNum = '';
    curNum = '';
    opr = '';
  }

  double convertStringTODounble(String number) {
    return double.tryParse(number) ?? 0;
  }

  String _forRes(String number) {
    var formatter = NumberFormat("###,###.##", 'en-us');
    return formatter.format(convertStringTODounble(number));
  }
}
