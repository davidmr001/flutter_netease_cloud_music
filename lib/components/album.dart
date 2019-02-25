import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../color.dart';

class AlbumWidget extends StatelessWidget {
  AlbumWidget({this.item});
  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Image(image: CachedNetworkImageProvider(this.item['picUrl'])),
          ),
          Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(this.item['name'],
                  maxLines: 1, overflow: TextOverflow.ellipsis)),
          Text(this.item['artist']['name'],
              style: TextStyle(color: AppColors.secondFont, fontSize: 13),
              maxLines: 1, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
