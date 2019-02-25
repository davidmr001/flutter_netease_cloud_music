import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../pages/playlist.dart';
import '../util.dart';
class PersonalizedWidget extends StatelessWidget {
  PersonalizedWidget({this.item});
  final Map item;

  void openPlayList(context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => PlayList(
                  id: this.item['id'],
                )));
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openPlayList(context),
      child: Container(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: Stack(
                children: <Widget>[
//                CachedNetworkImage(imageUrl: this.item['picUrl'], fit: BoxFit.fitWidth,),
                  Image(
                    image: CachedNetworkImageProvider(this.item['picUrl']),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        height: 30,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Color(0x66000000),
                              Color(0x00000000),
                            ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.headset,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              Util.translatePlayCount(this.item['playCount']),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(this.item['name'],
                    maxLines: 2, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
