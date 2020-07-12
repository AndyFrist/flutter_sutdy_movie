import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//导入电影列表页面
import './detail.dart';

Dio dio = new Dio();

class MovieList extends StatefulWidget {
// 构造函数固定写法 MovieList({Key key}):super(key:key);
  MovieList({Key key, @required this.mt}) : super(key: key);
  final String mt;

  @override
  _MovieListState createState() {
    return _MovieListState();
  }
}

//有状态控件 ，必须结合一个状态管理类，来进行实现
class _MovieListState extends State<MovieList> with AutomaticKeepAliveClientMixin{

  //默认显示第一页数据
  int page = 1;

//每页显示的数据条数
  int pagesize = 10;

//电影列表数据
  var mlist = [];

//总数据条数，实现分页效果的
  int total = 0;

  //AutomaticKeepAliveClientMixin 实现tab页面切换时数据保持
  @override
  bool get wantKeepAlive => true;

  //控件被创建的时候，会执行initState
  @override
  void initState() {
    super.initState();
    getMoiveList();
  }

  //渲染当前这个MovieList 控制的UI结构
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mlist.length,
        itemBuilder: (BuildContext ctx, int i) {
          //每次循环都拿到当前电影的item数据
          var mitem = mlist[i];

          return GestureDetector(
            onTap: () {
              //跳到详情页
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext ctx) {
                return new MoiveDetail(id: mitem['id'], title: mitem['title']);
              }));
            },
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.black12))),
              child: Row(
                children: <Widget>[
                  Image.network(mitem['images']['small'],
                      width: 130.0, height: 180.0, fit: BoxFit.cover),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: 200.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('电影名称：${mitem['title']}'),
                        Text('上映年份：${mitem['year']}年'),
                        Text('电影类型：${mitem['genres'].join('，')}'),
                        Text('豆瓣评分：${mitem['rating']['average']}分'),
                        Text('电影名称：${mitem['title']}') //todo
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  getMoiveList() async {
    //偏移量的计算公式（page - 1） * pagesize
    int offset = (page - 1) * pagesize;
    var response = await dio.get(
        'https://api.douban.com/v2/movie/${widget.mt}?city=%E5%B9%BF%E5%B7%9E&start=$offset&count=$pagesize');

    var resoult = response.data;
    print(resoult);

    //今后只要为私有数据赋值，都需要把赋值的操作放到setState 函数中，否则页面不会刷新
    setState(() {
      //通过dio返回的数据，必须使用【】来访问
      mlist = resoult['subjects'];
      total = resoult['total'];
    });
  }
}
