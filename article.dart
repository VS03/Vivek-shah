import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_info.dart';
import 'model/article_detail.dart';
import 'styles.dart';

class ArticleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleScreenState();
  }
}

class _ArticleScreenState extends State<ArticleScreen> {
  final List<ArticleDetail> items = [];

  @override
  void initState() {
    super.initState();
    getArticle();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text("Article", style: Styles.navBarTitle,)),
        body: ListView.builder(
            itemCount: this.items.length,
            itemBuilder: _listViewItemBuilder
        )
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index){
    var articleDetail = this.items[index];
    return ListTile(
        contentPadding: EdgeInsets.all(10.0),
        // leading: _itemThumbnail(articleDetail),
        title: _itemTitle(articleDetail),
        onTap: (){
          _navigationToArticleDetail(context, articleDetail);
        });
  }
  void _navigationToArticleDetail(BuildContext context, ArticleDetail articleDetail){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context){return ArticleInfo(articleDetail);}
        ));
  }

  Widget _itemTitle(ArticleDetail articleDetail){
    return Text(articleDetail.title + ": " + articleDetail.description, style: Styles.textDefault);
  }

  void getArticle() async{
    final http.Response response = await http.get("https://hubblesite.org/api/v3/news");
    final List<dynamic> responsedata = json.decode(response.body);
    final responseData =  List<Map<String, dynamic>>.from(responsedata.whereType<Map<String, dynamic>>());

    for(int i=0; i<responseData.length; i++){
      Map<String, dynamic> resp = responseData[i];
      final ArticleDetail article = ArticleDetail(
          description: resp['name'],
          title: resp['article_id'],
          url: resp['url']
      );
      setState(() {
        items.add(article);
      });
    }
  }
}