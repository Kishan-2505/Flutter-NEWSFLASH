import 'dart:async';

import 'package:flutter/material.dart';
import "package:webview_flutter/webview_flutter.dart";


class ArticleView extends StatefulWidget {
  final String blogUrl;
  ArticleView({this.blogUrl, String imageUrl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           iconTheme: new IconThemeData(color: Colors.black),
          title: Row(
            children: <Widget>[
              SizedBox(width: 55),
              Text(
                'News',
                style: TextStyle(
                  //fontFamily: 'Pacifico',
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Baumans',
                  fontSize: 30,
                  color: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
              ),
              Text(
                'Feed',
                style: TextStyle(
                  fontFamily: 'Baumans',
                  color: Colors.green,
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
         body:Container(
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated : ((WebViewController webViewController){
            _completer.complete(webViewController);
          })
        ),
      ),  
    );
  }
}
