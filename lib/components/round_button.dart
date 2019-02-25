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
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryMaterialColor[100],
                      offset: Offset(0, 2),
                      blurRadius: 4.0)
                ],
                borderRadius: BorderRadius.all(Radius.circular(38))),
            child: Icon(
              IconData(this.codePoint, fontFamily: 'iconfont'),
              color: Colors.white,
            ),
          ),
          Text(this.title)
        ],
      ),
      onTap: this.onClick,
    );
  }
}
