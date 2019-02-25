import 'package:flutter/material.dart';
import '../color.dart';

class TitleWithMore extends StatelessWidget {
  TitleWithMore({this.title});
  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 25, bottom: 18),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Text(
            this.title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Icon(Icons.chevron_right, size: 18, color: AppColors.secondFont),
        ],
      ),
    );
  }
}
