import 'package:dio/dio.dart';

// tool: https://caijinglong.github.io/json2dart/index_ch.html
class Api {
  static const String host = 'http://192.168.1.2:3000/';

  static Api _instance;
  Dio dio;

  static Api getInstance() {
    if (_instance != null) return _instance;
    _instance = new Api();
    _instance._internal();
    return _instance;
  }

  List<Map> toList(data) {
    return (data as List).map((e) {
      return e as Map<String, dynamic>;
    }).toList();
  }

  void _internal() {
    this.dio = new Dio(BaseOptions(baseUrl: host));
//    this.dio.transformer= new FlutterTransformer();
  }

  Future<List> banner() async {
    Response response = await this.dio.get("/banner");
    Map data = response.data;
    if (data['code'] == 200) {
      return toList(data['banners']);
    } else {
      throw Exception('load banner error');
    }
  }

  Future<List> personalized() async {
    Response response = await this.dio.get("/personalized");
    Map data = response.data;
    if (data['code'] == 200) {
      return toList(data['result']);
    } else {
      throw Exception('load personalized error');
    }
  }

  Future<List> album_newest() async {
    Response response = await this.dio.get("/album/newest");
    Map data = response.data;
    if (data['code'] == 200) {
      return toList(data['albums']);
    } else {
      throw Exception('load album newest error');
    }
  }

  Future<List> djprogram() async {
    Response response = await this.dio.get("/dj/recommend");
    Map data = response.data;
    if (data['code'] == 200) {
      return toList(data['djRadios']);
    } else {
      throw Exception('load djprogram error');
    }
  }

  Future<Map> playlist_detail(id) async {
    Response response = await this.dio.get("/playlist/detail?id=$id");
    Map data = response.data;
    if (data['code'] == 200) {
      return data['playlist'];
    } else {
      throw Exception('load playlist detail error');
    }
  }
}
