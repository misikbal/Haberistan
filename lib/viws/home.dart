import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haberistan/Screens/login.dart';
import 'package:haberistan/helper/data.dart';
import 'package:haberistan/helper/news.dart';
import 'package:haberistan/models/article_model.dart';
import 'package:haberistan/models/category_model.dart';
import 'package:haberistan/viws/article_view.dart';
import 'package:haberistan/viws/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  int currentIndex = 0;
  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News nenwsClas = News();
    await nenwsClas.getNews();
    articles = nenwsClas.news;
    setState(() {
      _loading = false;
    });
  }
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Haber"),
              Text(
                "istan",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(height: 30),
              DrawerHeader(
                  child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/images/haberistanLogo.png'),
              )),
              SizedBox(height: 20),
              Text(
                "Profilim",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 45),
              Text(
                "Ayarlar",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 45),
              Text(
                "Hakkımızda",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 45),
              Text(
                "Çıkış Yap",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 45),
              Material(
                borderRadius: BorderRadius.circular(500),
                child: InkWell(
                  borderRadius: BorderRadius.circular(500),
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xff495A6A),
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xff495A6A),
                    child: Center(
                      child: Text(
                        "Haberistan v1.0.1",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )),
              ))
            ],
          ),
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : <Widget>[
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 70,
                          child: ListView.builder(
                              itemCount: categories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CategoryTile(
                                  imageUrl: categories[index].imageUrl,
                                  categoryName: categories[index].categoryName,
                                  apiName: categories[index].apiName,
                                );
                              }),
                        ),
                        //Haber Kartları
                        Container(
                          padding: EdgeInsets.only(top: 16),
                          child: ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              // debugPrint(articles[index].description);
                              return BlogTile(
                                imageUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url,
                                // date:articles[index].publishedAt
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width:750,
                  height:750,
                  color:Colors.white,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/yakinda.jpg'),                 

                    ],
                  )
                ),
                Container(
                  width:750,
                  height:750,
                  color:Colors.white,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/yakinda.jpg'),                  

                    ],
                  )
                ),
                LoginPage(),
              ][currentIndex],
          bottomNavigationBar: BubbleBottomBar(
            opacity: .2,
            currentIndex: currentIndex,
            onTap: changePage,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            elevation: 8,
            hasNotch: true,
            hasInk: true,
            inkColor: Colors.black12,
            items: <BubbleBottomBarItem>[
              BubbleBottomBarItem(
                  backgroundColor: Colors.black,
                  icon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: 21,
                    color: Colors.black54,
                    height: 21,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: 21,
                    color: Colors.black54,
                    height: 21,
                  ),
                  title: Text("Anasayfa")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.black,
                  icon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 21,
                    color: Colors.black54,
                    height: 21,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 21,
                    color: Colors.black54,
                    height: 21,
                  ),
                  title: Text("Ara")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.black,
                  icon: SvgPicture.asset(
                    'assets/icons/bookmark.svg',
                    width: 21,
                    color: Colors.black54,
                    height: 21,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/bookmark.svg',
                    width: 21,
                    color: Colors.black54,
                    height: 21,
                  ),
                  title: Text("Yer İşaretleri")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.black,
                  icon: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/user.png')),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff495A6A),
                              offset: Offset(0, 1),
                              blurRadius: 5,
                            )
                          ])),
                  title: Text("Hesap")),
            ],
        ));
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName, apiName;
  CategoryTile({this.imageUrl, this.categoryName, this.apiName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: apiName.toLowerCase(),
            ),
          ),
        );
        debugPrint(categoryName);
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
                    fit: BoxFit.cover)),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.url,
    // @required this.date
  });
  @override
  
  Widget build(BuildContext context) {

    // int tarih=int.parse(date.split("T")[1].split("Z")[0].split(":")[0])+3;
    // String fullDate=tarih.toString()+":"+date.split("T")[1].split("Z")[0].split(":")[1];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleView(
                    blogUrl: url,
                  )),
        );
        
        
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imageUrl),
            ),
            // SizedBox(height: 10),
            // Text(
            //   date
            //   // (date.split("T")[1].split("Z")[0].split(":")[0])
            //   ,
            //   style: TextStyle(fontSize: 17, color: Colors.grey),
            // ),
            SizedBox(height: 10),

            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Text(
              desc,
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),            
          ],
        ),
      ),
    );
  }
}
