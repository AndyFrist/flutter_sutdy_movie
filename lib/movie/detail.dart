import 'package:flutter/material.dart';

class MoiveDetail extends StatefulWidget {
  MoiveDetail({Key key, @required this.id, @required this.title})
      : super(key: key);
  final String id;
  final String title;

  @override
  _MoiveDetailState createState() {
    return _MoiveDetailState();
  }
}

class _MoiveDetailState extends State<MoiveDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Text('电影id为：${widget.id}' ),
    );
  }
}
