import 'dart:io';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:srbg/utils/CustomRoute.dart';
import 'package:srbg/net/Api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'entry/Album.dart';
import 'pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, //设置状态栏颜色
          statusBarBrightness: Brightness.light //设置沉浸式第一步
          ));
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    }

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Startup Name Generator',
            routes: <String,WidgetBuilder>{
              'login':(context) => const LoginPage()
            },
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const Scaffold(
              body: Center(
                child: RandomWords(),
              ),
            ),
            builder: EasyLoading.init(), //初始化加载框
          );
        });
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  late Future<Album> futureAlbum;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAlbum = fetchAlbum();
  }

  //跳转收藏夹
  void _pushSaved() {
    // Navigator.of(context).push(CustomRouteSlide(_collectWidget())
    Navigator.of(context).push(CustomRouteSlide(const LoginPage()));
        // MaterialPageRoute<void>(
        //   builder: (BuildContext context) {
        //     final Iterable<ListTile> tiles = _saved.map(
        //       (WordPair pair) {
        //         return ListTile(
        //           title: Text(
        //             pair.asPascalCase,
        //             style: _biggerFont,
        //           ),
        //         );
        //       },
        //     );
        //     final List<Widget> divided = ListTile.divideTiles(
        //       context: context,
        //       tiles: tiles,
        //     ).toList();
        //
        //     return Scaffold(
        //       //搜藏页面
        //       // 新增 6 行代码开始 ...
        //       appBar: AppBar(
        //         title: const Text('Saved Suggestions'),
        //       ),
        //       body: ListView(children: divided),
        //     );
        //   }
        // ),
        // );
  }

  Widget _collectWidget() {
    final Iterable<ListTile> tiles = _saved.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('collect')),
      //搜藏页面
      // 新增 6 行代码开始 ...
      body: ListView(children: divided),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _pushWidget();
  }

  Widget _pushWidget() {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
          // systemOverlayStyle: SystemUiOverlayStyle.dark, //状态栏字体颜色
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body:
            // ListView.builder(
            //   //列表
            //   padding: const EdgeInsets.all(16.0),
            //   itemBuilder: (context, i) {
            //     if (i.isOdd) return const Divider();
            //     final index = i ~/ 2;
            //     if (index >= _suggestions.length) {
            //       _suggestions.addAll(generateWordPairs().take(10));
            //     }
            //     return _buildRow(_suggestions[index]);
            //   },
            // ),
            Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('${snapshot.data!.userId}');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const Text('');
            },
          ),
        ));
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
