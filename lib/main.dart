import 'package:flutter/material.dart';
//导入电影列表页面
import './movie/movielist.dart';
//入口函数
void main() => runApp(MyApp());

//无状态 StatelessWidget ，有状态 StatefullWidget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "电影集中营",
        theme: ThemeData(
          //主题颜色
          primarySwatch: Colors.blue,
        ),
        home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //在flutter中，每个控件都是一个class
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text('电影列表'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                )
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountEmail: Text('948879263@qq.com'),
                    accountName: Text('徐某'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=475179095,534153499&fm=27&gp=0.jpg'),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://pic4.zhimg.com/v2-7116aaada605b698083dc18d72c35a5c_im.jpg'))),
                  ),
                  ListTile(
                    title: Text('用户反馈'),
                    trailing: Icon(Icons.feedback),
                  ),
                  ListTile(
                    title: Text('系统设置'),
                    trailing: Icon(Icons.settings),
                  ),
                  ListTile(
                    title: Text('我要发布'),
                    trailing: Icon(Icons.send),
                  ),
                  //分割线控件
                  Divider(color: Colors.blue),
                  ListTile(
                    title: Text('注销'),
                    trailing: Icon(Icons.exit_to_app),
                  ),
                ],
              ),
            ),
            //底部的tabbar
            bottomNavigationBar: Container(
              height: 50.0, //一般tabbar高都是50
              decoration: BoxDecoration(color: Colors.black),
              child: TabBar(
                labelStyle: TextStyle(height: 0, fontSize: 10),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.movie_filter),
                    text: '正在热映',
                  ),
                  Tab(
                    icon: Icon(Icons.movie_creation),
                    text: '即将上映',
                  ),
                  Tab(
                    icon: Icon(Icons.local_movies),
                    text: 'Top250',
                  ),
                ],
              ),
            ),
          body: TabBarView(children: <Widget>[
            MovieList(mt: 'in_theaters',),
            MovieList(mt: 'coming_soon',),
            MovieList(mt: 'top250',),

          ]),
        )
    );
  }
}
