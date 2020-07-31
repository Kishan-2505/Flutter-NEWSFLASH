import 'package:flutter/material.dart';
import 'package:news_flash/helper/news.dart';
import 'package:news_flash/models/article_model.dart';

import 'article_views.dart';

class CategoryNews extends StatefulWidget {

  final String category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

List<ArticleModel> articles = new List<ArticleModel>();
bool _loading = true;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

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

        body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                 ///Blogs
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics:ClampingScrollPhysics() ,
                        itemBuilder: (context, index) {
                          return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url,
                              );
                        }),
                  )
              ],
            ),
          ),
        ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc,url;
  BlogTile(
      {@required this.imageUrl, @required this.title, @required this.desc,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => ArticleView(
          imageUrl: url,
        )));
      },
          child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(desc,style: TextStyle(color:Colors.black54),),
          ],
        ),
      ),
    );
  }
}
