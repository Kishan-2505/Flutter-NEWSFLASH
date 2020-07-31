import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:news_flash/helper/data.dart';
import 'package:news_flash/helper/news.dart';
import 'package:news_flash/models/article_model.dart';
import 'package:news_flash/models/category_model.dart';
import 'package:news_flash/views/category_news.dart';

import 'article_views.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          title: Row(
            children: <Widget>[
              SizedBox(width: 55),
              Text(
                'news',
                style: TextStyle(
                  fontFamily: 'Baumans',
                  fontWeight: FontWeight.normal,
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
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text('Kishan Rathod',style: TextStyle(fontFamily:'Baumans'),),
                accountEmail: Text('kishanrathod@gmail.com',style: TextStyle(fontFamily:'Baumans'),),
                otherAccountsPictures: <Widget>[
                  new CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text('K'),
                  ),
                ],
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('Images/kishan.jpg'),
                  foregroundColor: Colors.red,
                ),
                decoration: BoxDecoration(
                  color: Hexcolor('344955'),
                ),
              ),
              new ListTile(
                title: Text('Profile',style: TextStyle(fontFamily:'Baumans'),),
                trailing: Icon(Icons.account_circle),
              ),
              new ListTile(
                title: Text('Settings',style: TextStyle(fontFamily:'Baumans'),),
                trailing: Icon(Icons.settings),
              ),
              new ListTile(
                title: Text('LogOut',style: TextStyle(fontFamily:'Baumans'),),
                onTap: () => Navigator.of(context).pop(),
                trailing: Icon(Icons.cancel),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: Hexcolor('344955'),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Hexcolor('344955'),
          height: 55,
          items: <Widget>[
            Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.list,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.compare_arrows,
              size: 30,
              color: Colors.white,
            ),
          ],
          animationDuration: Duration(
            milliseconds: 600,
          ),
          index: 1,
          animationCurve: Curves.decelerate,
          onTap: (index) {
            debugPrint('Current Index is $index');
          },
        ),
        body: // color: Colors.white,
            /* _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )*/
            // :

            SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                ///Categories
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 70,
                  child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        );
                      }),
                ),

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
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            category:categoryName.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
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
