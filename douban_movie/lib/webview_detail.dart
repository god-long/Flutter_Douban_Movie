import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewDetail extends StatefulWidget {
  final String urlString;
  WebViewDetail({Key key, this.urlString}) : super(key: key);

  @override
  createState() => new WebViewDetailState();
}

class WebViewDetailState extends State<WebViewDetail> {

  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      appBar: new AppBar(
        title: Text('WebView'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () => launchUrl(),
          )
        ],
      ),
      url: widget.urlString,
      withZoom: true,
    );
  }


  launchUrl() {
    setState(() {
      print(widget.urlString);
      flutterWebviewPlugin.reloadUrl(widget.urlString);
    });
  }
}


class WebViewDemoPage extends StatefulWidget {
  final String urlString;

  WebViewDemoPage({Key key, this.urlString}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _WebViewDemoPagePageState();
}
class _WebViewDemoPagePageState extends State<WebViewDemoPage> {
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var urlString2 = "http://www.baidu.com";
  @override
  void initState() {
    super.initState();
    //监听页面状态改变
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });
    //监听页面滚动事件
    flutterWebviewPlugin.onScrollYChanged.listen((double offsetY) {
      print('offsetY: $offsetY');
    });
    flutterWebviewPlugin.onScrollXChanged.listen((double offsetX) {
      print('offsetX: $offsetX');
    });
  }
  launchUrl() {
    setState(() {
      urlString2 = widget.urlString;
      flutterWebviewPlugin.reloadUrl(urlString2);
    });
  }
  Widget build(BuildContext context) {
//    return WebviewScaffold(
//        appBar: new AppBar(
//          title: new Text('WebView Demo'),
//        ),
//        url: 'http://www.appblog.cn',
//    );
    return WebviewScaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: false,
          controller: controller,
          textInputAction: TextInputAction.go,
          onSubmitted: (url) => launchUrl(),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter Url Here",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () => launchUrl(),
          )
        ],
      ),
      url: widget.urlString,
      withZoom: false,
    );
  }
}