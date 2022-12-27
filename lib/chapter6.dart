import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "SingleChildScrollView_demo": (context) =>SingleChildScrollViewTestRoute(),
          "TabbarView_demo": (context) => TabBarViewComponent(title:"TabbarView"),
          "/": (context) => MyHomePage(title: '可滚动组件'), //注册首页路由
        });
  }
}

class SingleChildScrollViewTestRoute extends StatelessWidget {
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SingleChildScrollView"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      ///动态创建一个List<Widget>
                      children: str
                          .split("")
                      //每一个字母都用一个Text显示,字体为原来的两倍
                          .map((c) => Text(
                        c,
                        textScaleFactor: 2.0,
                      ))
                          .toList(),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}




class TabBarViewComponent extends StatefulWidget {
  const TabBarViewComponent({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TabBarViewComponent> createState() {
    return TabBarViewState();
  }
}

class TabBarViewState extends State<TabBarViewComponent>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List tabs = ["热门", "推荐", "图片", "科技", "手机"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        bottom: TabBar(
          controller: tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs.map((e) {
          return AutomaticKeepAlive(
            child: Container(
              alignment: Alignment.center,
              child: Text(e, textScaleFactor: 5),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text("SingleChildScrollView_demo"),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.green,
                textStyle: const TextStyle(fontSize: 25),
              ),


              onPressed: () {
                //导航到新路由
                Navigator.pushNamed(context, "SingleChildScrollView_demo");
              },
            ),
            TextButton(
              child: Text("TabbarView"),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.green,
                textStyle: const TextStyle(fontSize: 25),
              ),
              onPressed: () {
                //导航到新路由
                Navigator.pushNamed(
                    context, "TabbarView_demo");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
