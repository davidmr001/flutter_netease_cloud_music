import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DjProgramWidget extends StatelessWidget {
  DjProgramWidget({this.item});
  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Stack(
              children: <Widget>[
                Image(image: CachedNetworkImageProvider(this.item['picUrl'])),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      height: 26,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Color(0x66000000),
                            Color(0x00000000),
                          ],
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter)),
                      child: Text(
                        this.item['name'],
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(this.item['rcmdtext'],
                  maxLines: 2, overflow: TextOverflow.ellipsis))
        ],
      ),
    );
  }
}
