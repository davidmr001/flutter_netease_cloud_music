import 'package:flutter/material.dart';
import '../color.dart';

class MusicItem extends StatelessWidget {
  MusicItem({this.index, this.name, this.ar, this.al});

  final int index;
  final String name;
  final String ar;
  final String al;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: 50,
            child: Text(
              this.index.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 24),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border))),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        this.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${this.ar} - ${this.al}',
                        style: TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
