import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../color.dart';

class BannerBox extends StatefulWidget {
  List<Map> banners = [];
  BannerBox({Key key, @required this.banners}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BannerBox();
  }
}

class _BannerBox extends State<BannerBox> {
  PageController controller = PageController();
  int _index = 0;

  handlePageChange(int index) {
    setState(() {
      this._index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 812 / 293,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                decoration: BoxDecoration(color: AppColors.primary),
                height: 115,
              ),
            ),
            PageView(
              onPageChanged: handlePageChange,
              children: widget.banners.map((item) {
                return Item(item: item);
              }).toList(),
              controller: controller,
            ),
            Positioned(
              bottom: 14,
              left: 0,
              right: 0,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.banners.map((item) {
                  int index = widget.banners.indexOf(item);
                  return Dot(active: index == this._index);
                }).toList(),
              ),
            )
          ],
        ));
  }
}

class Item extends StatelessWidget {
  Item({this.item});

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Image(
                image: CachedNetworkImageProvider(item['imageUrl']),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(color: AppColors.primary),
                child: Center(
                  child: Text(
                    item['typeTitle'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  Dot({this.active});

  final active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: active ? Color(0xc7e74939) : Color(0xc7eeeeee),
          borderRadius: BorderRadius.all(Radius.circular(4))),
    );
  }
}
