// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:platina/domain/models/articles.dart';
import 'package:platina/domain/models/authors_offered.dart';
import 'package:platina/domain/models/business_posts.dart';
import 'package:platina/domain/models/currency.dart';
import 'package:platina/domain/models/menues.dart';
import 'package:platina/domain/models/news_detail.dart';
import 'package:platina/domain/models/popular_post.dart';
import 'package:platina/domain/models/posts.dart';
import 'package:platina/domain/models/posts_by_category.dart';
import 'package:platina/domain/models/search_results.dart';
import 'package:platina/domain/models/video.dart';
import 'package:platina/domain/models/weather.dart';
import 'package:platina/domain/urls.dart';

class Repository {
  var headers = {
    'X-PLATINA-API-KEY': 'QdO5hA3D.iSevNc03mulrumyLiPqlcM03M9clZdDQ'
  };
  Future<PopularPosts> getPopularPosts(page) async {
    var request =
        http.Request('GET', Uri.parse(BASE_URL + POPULAR_POSTS + "?page$page"));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      PopularPosts posts =
          popularPostsFromJson(utf8.decode(response.bodyBytes));
      return posts;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<AuthorsOffered> getAuthorsOfferedPosts() async {
    var request = http.Request('GET', Uri.parse(BASE_URL + AUTHORS_OFFERED));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      AuthorsOffered posts =
          authorsOfferedFromJson(utf8.decode(response.bodyBytes));

      return posts;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<Posts> getPosts(PAGE) async {
    var request =
        http.Request('GET', Uri.parse(BASE_URL + POSTS + "?page=$PAGE"));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      Posts posts = postsFromJson(utf8.decode(response.bodyBytes));

      return posts;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<List<BusinessPosts>> getBusinessPosts() async {
    var request = http.Request(
        'GET', Uri.parse("https://cp.dev.platina.uz/uz/api/posts/business"));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      List<BusinessPosts> posts =
          businessPostsFromJson(utf8.decode(response.bodyBytes));

      return posts;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<List<Menues>> getMenues() async {
    var request = http.Request('GET', Uri.parse(BASE_URL + MENU));

    request.headers.addAll(headers);
    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      List<Menues> categories = menuesFromJson(utf8.decode(response.bodyBytes));
      return categories;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<Weather> getWeather() async {
    var response = await http.post(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=tashkent&cnt=7&appid=601257e021387c5b9b5f2c47a070e1ff&units=metric'));

    if (response.statusCode == 200) {
      Weather weather = weatherFromJson(response.body);
      return weather;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<PostsByCategory> getPostsByCategory(CATEGORY) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        BASE_URL + POST_BY_CATEGORY + "/" + CATEGORY,
      ),
    );

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      PostsByCategory post =
          postsByCategoryFromJson(utf8.decode(response.bodyBytes));
      return post;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<List<Currency>> getCurrency() async {
    var headers = {'Cookie': 'PHPSESSID=WS7SQxKfZAPFtZWPVMbNF2Rsn8g117Uq'};
    var request = http.Request('GET', Uri.parse('https://cbu.uz/common/json/'));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      List<Currency> currency = currencyFromJson(
        utf8.decode(response.bodyBytes),
      );
      return currency;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<Articles> getArticles(page) async {
    var request =
        http.Request('GET', Uri.parse(BASE_URL + ARTICLES + "?page=$page"));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      Articles articles = articlesFromJson(utf8.decode(response.bodyBytes));

      return articles;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<Video> getVideo(page) async {
    var request =
        http.Request('GET', Uri.parse(BASE_URL + VIDEO + "?page=$page"));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      Video video = videoFromJson(utf8.decode(response.bodyBytes));
      return video;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<NewsDetail> getNewsDetail(YEAR, MONTH, DAY, SLUG) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            BASE_URL + '/' + YEAR + '/' + MONTH + '/' + DAY + '/' + SLUG));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      NewsDetail newsDetail =
          newsDetailFromJson(utf8.decode(response.bodyBytes));
      return newsDetail;
    } else {
      return throw Exception(response.body);
    }
  }

  Future<SearchResult> search(QUERY) async {
    var request = http.Request('GET', Uri.parse(BASE_URL + SEARCH + QUERY));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      SearchResult searchResult =
          searchResultFromJson(utf8.decode(response.bodyBytes));
      return searchResult;
    } else {
      return throw Exception(response.body);
    }
  }
}
