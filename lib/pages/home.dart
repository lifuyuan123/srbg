import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../utils/toast.dart';
final navigatorState = GlobalKey<NavigatorState>();
///首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
 return  MaterialApp(
   navigatorKey: navigatorState,
        home: const Scaffold(
          body: Center(
            child: RandomWords(),
          ),
        ),
 );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // late Future<Album> futureAlbum;
  DateTime _lastTime = DateTime.now();
  @override
  void initState() {
    super.initState();

    ///网络请求
    // futureAlbum = fetchAlbum();
  }

  //跳转收藏夹
  void _pushSaved() {
    // Navigator.of(context).push(CustomRouteSlide(_collectWidget())
    // Navigator.of(context).push(CustomRouteSlide(const LoginPage()));
    context.push('/login');
    //跳转页面
    // Navigator.of(context).push(CustomRouteSlide(const Test1()));
  }

  @override
  Widget build(BuildContext context) {
    return _pushWidget();
  }

  ///网络请求数据
  Widget _pushWidget() {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
          systemOverlayStyle: SystemUiOverlayStyle.dark, //状态栏字体颜色
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: WillPopScope(
            onWillPop: () async {
              if (DateTime.now().difference(_lastTime) >
                  const Duration(seconds: 2)) {
                _lastTime = DateTime.now();
                Toast.toast('再点击一次退出app');
                return false;
              }
              return true;
            },
            child: Center(
              ///处理网络数据
              // child: FutureBuilder<Album>(
              //   future: futureAlbum,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Text('${snapshot.data!.userId}');
              //     } else if (snapshot.hasError) {
              //       return Text('${snapshot.error}');
              //     }
              //     // By default, show a loading spinner.
              //     return const Text('');
              //   },
              // ),
            )
        )
    );
  }
}