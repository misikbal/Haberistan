import 'dart:convert';
import 'package:haberistan/models/article_model.dart';
import "package:http/http.dart" as http;

class News{
  List<ArticleModel> news=[];
  Future<void> getNews() async{
    String url="https://newsapi.org/v2/top-headlines?country=tr&apiKey=42c4501d17004763999d04fe4871bfa0";
    var response=await http.get(Uri.parse(url));
    var jsonData=jsonDecode(response.body);
    if(jsonData["status"]=="ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){
          ArticleModel acticleModel =ArticleModel(
            title:element["title"],
            author:element["author"],
            description:element["description"],
            url:element["url"],
            urlToImage: element["urlToImage"],            
            content:element["content"],
            publishedAt:element["publishedAt"]
          );
          news.add(acticleModel);

        }
      });
    }

  }
}

class CategoryNewsClass{
  List<ArticleModel> news=[];
  Future<void> getCategoryNews(String category) async{
    String url="https://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=42c4501d17004763999d04fe4871bfa0";
    var response=await http.get(Uri.parse(url));
    var jsonData=jsonDecode(response.body);
    if(jsonData["status"]=="ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){
          ArticleModel acticleModel =ArticleModel(
            title:element["title"],
            author:element["author"],
            description:element["description"],
            url:element["url"],
            urlToImage: element["urlToImage"],            
            content:element["content"],
          );
          news.add(acticleModel);

        }
      });
    }

  }
}