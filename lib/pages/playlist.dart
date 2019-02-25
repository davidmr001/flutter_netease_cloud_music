import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui' as ui show ImageFilter;
import '../api.dart';
import '../util.dart';
import '../color.dart';
import '../components/round_button_without_color.dart';
import '../components/music_item.dart';

class PlayList extends StatefulWidget {
  PlayList({this.id});
  final int id;

  @override
  State<StatefulWidget> createState() {
    return _PlayList();
  }
}

class _PlayList extends State<PlayList> {
  Map data = {};
  bool showTitle = false;
  ScrollController controller;

  @override
  void initState() {
    loadData();
    controller = ScrollController();
    controller.addListener(() {
      bool _showTitle = false;
      if (this.controller.offset > 0) {
        _showTitle = true;
      }
      if (this.showTitle != _showTitle) {
        this.setState(() {
          this.showTitle = _showTitle;
        });
      }
    });
    super.initState();
  }

  void loadData() async {
    Map data = await Api.getInstance().playlist_detail(widget.id);
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          controller: controller,
          slivers: <Widget>[
            SliverAppBar(
                pinned: true,
                expandedHeight: 302.0,
                title: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(showTitle ? this.data['name'] ?? 'Loading' : '歌单'),
                    Text(
                      this.data['description'] ?? '',
                      maxLines: 1,
                      style: TextStyle(fontSize: 8),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: null),
                  IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      onPressed: null),
                ],
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      this.data['coverImgUrl'] ?? ''))),
                        ),
                        Container(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                            child: Container(
                                color: Color(0x00FFFFFF),
                                padding: EdgeInsets.only(top: 80),
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Flex(
                                            direction: Axis.horizontal,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 120,
                                                width: 120,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6)),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Image(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(
                                                              this.data[
                                                                      'coverImgUrl'] ??
                                                                  '')),
                                                      Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          left: 0,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4),
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                                    gradient: LinearGradient(
                                                                        colors: [
                                                                  Color(
                                                                      0x66000000),
                                                                  Color(
                                                                      0x00000000),
                                                                ],
                                                                        begin: Alignment
                                                                            .topCenter,
                                                                        end: Alignment
                                                                            .bottomCenter)),
                                                            child: Flex(
                                                              direction: Axis
                                                                  .horizontal,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              4),
                                                                  child: Icon(
                                                                    Icons
                                                                        .headset,
                                                                    size: 14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  Util.translatePlayCount(
                                                                      this.data[
                                                                              'playCount'] ??
                                                                          0),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 14),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 20),
                                                      child: Text(
                                                        this.data['name'] ?? '',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22),
                                                      ),
                                                    ),
                                                    Flex(
                                                      direction:
                                                          Axis.horizontal,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 8),
                                                          child: SizedBox(
                                                            height: 25,
                                                            width: 25,
                                                            child: ClipOval(
                                                              child: Image.network(this
                                                                              .data[
                                                                          'creator'] !=
                                                                      null
                                                                  ? this.data[
                                                                          'creator']
                                                                      [
                                                                      'avatarUrl']
                                                                  : ""),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          this.data['creator'] !=
                                                                  null
                                                              ? this.data[
                                                                      'creator']
                                                                  ['nickname']
                                                              : "",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                        ),
                                                        Icon(
                                                            Icons.chevron_right,
                                                            color:
                                                                Colors.white70)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 13),
                                            child: Flex(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                Expanded(
                                                    child: RoundButton(
                                                        codePoint: 0xe602,
                                                        title: this.data[
                                                                    'commentCount'] !=
                                                                null
                                                            ? this
                                                                .data[
                                                                    'commentCount']
                                                                .toString()
                                                            : '0',
                                                        onClick: null)),
                                                Expanded(
                                                    child: RoundButton(
                                                        codePoint: 0xe601,
                                                        title: this.data[
                                                                    'shareCount'] !=
                                                                null
                                                            ? this
                                                                .data[
                                                                    'shareCount']
                                                                .toString()
                                                            : '0',
                                                        onClick: null)),
                                                Expanded(
                                                    child: RoundButton(
                                                        codePoint: 0xe6c2,
                                                        title: '下载',
                                                        onClick: null)),
                                                Expanded(
                                                    child: RoundButton(
                                                        codePoint: 0xe629,
                                                        title: '多选',
                                                        onClick: null)),
                                              ],
                                            ))
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6)),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Flex(
                                            direction: Axis.horizontal,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Container(
                                                padding: EdgeInsets.all(12),
                                                child: Flex(
                                                  direction: Axis.horizontal,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.play_circle_outline,
                                                      color: Colors.black87,
                                                    ),
                                                    RichText(
                                                        text: TextSpan(
                                                            text: '播放全部',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87),
                                                            children: [
                                                          TextSpan(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                              text:
                                                                  '(共${this.data['trackCount'] ?? '0'}首)'),
                                                        ]))
                                                  ],
                                                ),
                                              )),
                                              Container(
                                                height: 50,
                                                padding: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary),
                                                child: Flex(
                                                  direction: Axis.horizontal,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                    RichText(
                                                        text: TextSpan(
                                                            text: '收藏',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            children: [
                                                          TextSpan(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              text:
                                                                  '(${this.data['subscribedCount'] == null ? '0' : Util.translatePlayCount(this.data['subscribedCount'])})'),
                                                        ]))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ))),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                Map data = this.data['tracks'][index];
                return MusicItem(
                  index: index + 1,
                  name: data['name'],
                  al: data['al']['name'],
                  ar: data['ar'].map((i) => i['name']).join('/'),
                );
              }, childCount: this.data['trackCount'] ?? 0),
            )
          ],
        ),
      ),
    );
  }
}
