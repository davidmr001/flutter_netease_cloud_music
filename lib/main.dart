import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'color.dart';
import './pages/home.dart';
import 'components/player.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlayerInheritedStateContainer(
        data: PlayerState(),
        child: MaterialApp(
          title: '网易云音乐',
          theme: ThemeData(
            primarySwatch: AppColors.primaryMaterialColor,
          ),
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: '推荐',
    ),
    Tab(
      text: '朋友',
    ),
    Tab(
      text: '电台',
    ),
  ];

  final List<Widget> myTabViews = <Widget>[HomePage(), MyPage(), VideoPage()];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.dehaze, color: Colors.white), onPressed: null),
        title: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: IconButton(
                  icon: Icon(IconData(0xe6a4, fontFamily: 'iconfont'),
                      color: Color(0xFFf1b7b1)),
                  onPressed: null),
            ),
            Expanded(
                child: IconButton(
                    icon: Icon(IconData(0xe617, fontFamily: 'iconfont'),
                        color: Colors.white),
                    onPressed: null)),
            Expanded(
                child: IconButton(
                    icon: Icon(IconData(0xe658, fontFamily: 'iconfont'),
                        color: Color(0xFFf1b7b1)),
                    onPressed: null))
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: null),
        ],
        bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            indicatorPadding: EdgeInsets.only(bottom: 10.0)),
      ),
      body: TabBarView(
        children: myTabViews,
        controller: _tabController,
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPage();
  }
}

class _MyPage extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("hi this is my page"),
    );
  }
}

class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoPage();
  }
}

class _VideoPage extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("hi this is video page"),
    );
  }
}
