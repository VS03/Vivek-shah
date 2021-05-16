import 'package:flutter/material.dart';
import 'package:e_v_studio/model/article_detail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'styles.dart';

class ArticleInfo extends StatelessWidget {
  final ArticleDetail articleDetail;

  ArticleInfo(this.articleDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(articleDetail.title, style: Styles.navBarTitle,)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _renderBody(context, articleDetail),
        )
    );
  }

  List<Widget> _renderBody(BuildContext context, ArticleDetail articleDetail) {
    var result = List<Widget>();
    result.addAll(_renderInfo(context, articleDetail));
    return result;
  }

  List<Widget> _renderInfo(BuildContext context, ArticleDetail articleDetail) {
    var result = List<Widget>();
    // result.add(_sectionTitle(articleDetail.description));
    result.add(_page(articleDetail.url));
    return result;
  }

  _page(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}