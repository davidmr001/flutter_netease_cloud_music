import 'package:flutter/material.dart';

import '../components/banner.dart';
import '../components/round_button.dart';
import '../components/title_with_more.dart';
import '../components/personalized.dart';
import '../components/album.dart';
import '../components/djprogram.dart';
import '../components/player.dart';
import '../api.dart';
import '../color.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<Map> banners = [];
  List<Map> personalizeds = [];
  List<Map> album_newest = [];
  List<Map> djprogram = [];
  PlayerController playerController = PlayerController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<Null> loadData() async {
    List<Map> banners = await Api.getInstance().banner();
    List<Map> personalizeds = await Api.getInstance().personalized();
    List<Map> album_newest = await Api.getInstance().album_newest();
    List<Map> djprogram = await Api.getInstance().djprogram();

    this.setState(() {
      this.banners = banners;
      this.personalizeds = personalizeds;
      this.album_newest = album_newest;
      this.djprogram = djprogram;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return PlayerLayout(
      controller: playerController,
      hidden: false,
      child: RefreshIndicator(
          child: CustomScrollView(
            slivers: <Widget>[
              /**
               * 轮播图
               */
              SliverToBoxAdapter(
                child: BannerBox(banners: this.banners),
              ),
              /**
               * 按钮栏
               */
              SliverToBoxAdapter(
                child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: AppColors.border))),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: RoundButton(
                                codePoint: 0xe60c,
                                title: '私人FM',
                                onClick: null)),
                        Expanded(
                            child: RoundButton(
                                codePoint: 0xe600,
                                title: '每日推荐',
                                onClick: null)),
                        Expanded(
                            child: RoundButton(
                                codePoint: 0xe61a, title: '歌单', onClick: null)),
                        Expanded(
                            child: RoundButton(
                                codePoint: 0xe68c, title: '排行榜', onClick: null))
                      ],
                    )),
              ),

              /**
               * 推荐歌单
               */
              SliverToBoxAdapter(
                child: TitleWithMore(
                  title: '推荐歌单',
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return PersonalizedWidget(item: this.personalizeds[index]);
                  },
                      childCount: this.personalizeds.length >= 6
                          ? 6
                          : this.personalizeds.length),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //列
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 0.67,
                  ),
                ),
              ),
              /**
               * 最新专辑
               */
              SliverToBoxAdapter(
                child: TitleWithMore(
                  title: '最新专辑',
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return AlbumWidget(item: this.album_newest[index]);
                  },
                      childCount: this.album_newest.length >= 6
                          ? 6
                          : this.album_newest.length),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //列
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 0.67,
                  ),
                ),
              ),

              /**
               * 最新专辑
               */
              SliverToBoxAdapter(
                child: TitleWithMore(
                  title: '推荐电台',
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return DjProgramWidget(item: this.djprogram[index]);
                  },
                      childCount: this.djprogram.length >= 6
                          ? 6
                          : this.djprogram.length),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //列
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 0.67,
                  ),
                ),
              ),
            ],
          ),
          onRefresh: this.loadData),
    );
    ;
  }

  @override
  bool get wantKeepAlive => true;
}
