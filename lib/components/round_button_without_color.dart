import 'package:flutter/material.dart';
import '../color.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.codePoint, this.title, this.onClick});

  final GestureTapCallback onClick;
  final int codePoint;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 3),
            child: Icon(
              IconData(this.codePoint, fontFamily: 'iconfont'),
              color: Colors.white,
            ),
          ),
          Text(
            this.title,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      onTap: this.onClick,
    );
  }
}
