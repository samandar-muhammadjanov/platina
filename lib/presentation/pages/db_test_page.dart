import 'package:flutter/material.dart';
import 'package:platina/db/db.dart';
import 'package:platina/domain/models/articles.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<ArticleResult> articleList = [];

  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  Future<void> loadArticles() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    articleList = await dbHelper.fetchArticlesWithCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: ListView.builder(
        itemCount: articleList.length,
        itemBuilder: (context, index) {
          final article = articleList[index];
          return ListTile(
            title: Text(article.title),
            subtitle: Text(article.shortDescription),
            onTap: () {
              // Handle article tapping
            },
            leading: Image.network(article.image),
          );
        },
      ),
    );
  }
}
