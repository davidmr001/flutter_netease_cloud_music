import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import '../color.dart';

/// 数据实体
class PlayerState {
  List play_list = [];
  int current_id = null;
  Map current;
  bool playing = false;
}

/// 数据共享组件 InheritedWidget
class PlayerInheritedStateContainer extends InheritedWidget {
  final PlayerState data;
  final AudioPlayer audioPlayer = new AudioPlayer();

  PlayerInheritedStateContainer(
      {Key key, @required this.data, @required Widget child})
      : super(key: key, child: child);

  //定义一个方法，方便子树中的widget获取这个widget，进而获得共享数据。
  static PlayerInheritedStateContainer of(BuildContext context) {
    /**
     * 获取最近的给定类型的Widget，该widget必须是InheritedWidget的子类，
     * 并向该widget注册传入的context，当该widget改变时，
     * 这个context会重新构建以便从该widget获得新的值。
     * 这就是child向InheritedWidget注册的方法。
     */
    return context.inheritFromWidgetOfExactType(PlayerInheritedStateContainer);
  }

  play(String url) async {
    await audioPlayer?.stop();
    await audioPlayer?.play(url);
  }

  pause() async {
    await audioPlayer?.pause();
  }

  @override
  bool updateShouldNotify(PlayerInheritedStateContainer oldWidget) =>
      data != oldWidget.data;
}

/// 布局
class PlayerLayout extends StatefulWidget {
  PlayerLayout(
      {@required this.child, @required this.controller, this.hidden = true});
  final Widget child;
  final bool hidden;
  final PlayerController controller;

  @override
  State<StatefulWidget> createState() {
    return _PlayerLayout();
  }
}

class _PlayerLayout extends State<PlayerLayout> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(child: widget.child),
        PlayerWidget(controller: widget.controller, hidden: widget.hidden),
      ],
    );
  }
}

class PlayerController {
  Function play;
  Function setList;
  Function show;

  init({play, setList, show}) {
    this.play = play;
    this.setList = setList;
    this.show = show;
  }
}

/// 播放器组件
class PlayerWidget extends StatefulWidget {
  PlayerWidget({@required this.controller, @required this.hidden});
  final PlayerController controller;
  final hidden;

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidget();
  }
}

class _PlayerWidget extends State<PlayerWidget> {
  PlayerState state;

  @override
  void initState() {
    widget.controller.init(play: this.play, setList: this.setList);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (state == null) {
      state = PlayerInheritedStateContainer.of(context).data;
    }
  }

  bool isShow() {
    if (widget.hidden) return false;
    bool show = state.play_list.length > 0 && state.current_id != null;
    print(
        'can show: $show, length: ${state.play_list.length} id: ${state.current_id} ');
    return show;
  }

  setList(List list) {
    if (list.length > 0) {
      setState(() {
        state.play_list = list;
        state.current = list[0];
      });
    }
  }

  play(int id) {
    print('play $id');
    try {
      Map current = state.play_list.firstWhere((item) => item['id'] == id);
      PlayerInheritedStateContainer.of(context)
          .play('https://music.163.com/song/media/outer/url?id=$id.mp3');
      setState(() {
        state.current_id = id;
        state.playing = true;
        state.current = current;
      });
    } catch (e) {
      print(e);
    }
  }

  pause() {
    print('pause');
    PlayerInheritedStateContainer.of(context).pause();
    setState(() {
      state.playing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border))),
      height: isShow() ? 60 : 0,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                child: Image.network(
                    state.current == null ? '' : state.current['al']['picUrl']),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  state.current == null ? '' : state.current['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${state.current == null ? '' : state.current['ar'].map((i) => i['name']).join('/')}',
                  style: TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            )),
            state.playing == true
                ? IconButton(
                    icon: Icon(Icons.pause_circle_outline),
                    onPressed: () {
                      pause();
                    })
                : IconButton(
                    icon: Icon(Icons.play_circle_outline),
                    onPressed: () {
                      play(state.current_id);
                    }),
            IconButton(icon: Icon(Icons.list), onPressed: null),
          ],
        ),
      ),
    );
  }
}
