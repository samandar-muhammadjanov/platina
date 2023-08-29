import 'dart:async';
import 'package:path/path.dart';
import 'package:platina/domain/models/articles.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE categories (
      id INTEGER PRIMARY KEY,
      name TEXT,
      slug TEXT,
      color TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE articles (
      id INTEGER PRIMARY KEY,
      category_id INTEGER,
      title TEXT,
      short_description TEXT,
      relatesTo TEXT,
      description TEXT,
      slug TEXT,
      author_offered INTEGER,
      publish TEXT,
      is_pinned INTEGER,
      number_of_views INTEGER,
      image TEXT,
      image_extra_large TEXT,
      image_large TEXT,
      image_medium TEXT,
      image_small TEXT,
      image_source TEXT,
      image_name TEXT,
      gallery TEXT,
      short_url TEXT,
      youtube_link TEXT,
      tags TEXT,
      expired_at TEXT,
      language TEXT,
      FOREIGN KEY (category_id) REFERENCES categories (id)
    )
  ''');
  }

  Future<void> insertArticle(ArticleResult article) async {
    Database db = await instance.database;
    await db.insert(
      'articles',
      {
        'id': article.id,
        'category_id': article.category.id,
        'title': article.title,
        'short_description': article.shortDescription,
        'relatesTo': article.relatesTo,
        'description': article.description,
        'slug': article.slug,
        'author_offered': article.authorOffered ? 1 : 0,
        'publish': article.publish,
        'is_pinned': article.isPinned ? 1 : 0,
        'number_of_views': article.numberOfViews,
        'image': article.image,
        'image_extra_large': article.imageExtraLarge,
        'image_large': article.imageLarge,
        'image_medium': article.imageMedium,
        'image_small': article.imageSmall,
        'image_source': article.imageSource,
        'image_name': article.imageName,
        'gallery': article.gallery.join(', '),
        'short_url': article.shortUrl,
        'youtube_link': article.youtubeLink,
        'tags': article.tags.join(', '),
        'expired_at': article.expiredAt,
        'language': article.language,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ArticleResult>> fetchArticlesWithCategories() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('articles');
    return List.generate(maps.length, (i) {
      return ArticleResult(
        id: maps[i]['id'],
        category: Category(
          id: maps[i]['category_id'],
          name: maps[i]['name'], // Fetch category details if needed
          slug: maps[i]['slug'],
          color: maps[i]['color'],
        ),
        title: maps[i]['title'],
        shortDescription: maps[i]['short_description'],
        relatesTo: maps[i]['relatesTo'],
        description: maps[i]['description'],
        slug: maps[i]['slug'],
        authorOffered: maps[i]['author_offered'] == 1,
        publish: maps[i]['publish'],
        isPinned: maps[i]['is_pinned'] == 1,
        numberOfViews: maps[i]['number_of_views'],
        image: maps[i]['image'],
        imageExtraLarge: maps[i]['image_extra_large'],
        imageLarge: maps[i]['image_large'],
        imageMedium: maps[i]['image_medium'],
        imageSmall: maps[i]['image_small'],
        imageSource: maps[i]['image_source'],
        imageName: maps[i]['image_name'],
        gallery: maps[i]['gallery'],
        shortUrl: maps[i]['short_url'],
        youtubeLink: maps[i]['youtube_link'],
        tags: maps[i]['tags'].toString().split(', '),
        expiredAt: maps[i]['expired_at'],
        language: maps[i]['language'],
      );
    });
  }

  Future<void> insertData(String value) async {
    Database db = await instance.database;
    await db.insert('data', {'value': value});
  }

  Future<List<String>> fetchData() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('data');
    return List.generate(maps.length, (i) {
      return maps[i]['value'];
    });
  }
}
