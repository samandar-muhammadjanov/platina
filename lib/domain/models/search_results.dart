import 'dart:convert';

SearchResult searchResultFromJson(String str) =>
    SearchResult.fromJson(json.decode(str));

String searchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  SearchResult({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Category category;
  String title;
  String shortDescription;
  String description;
  String slug;
  DateTime publish;
  String getImageMediumUrl;
  int numberOfViews;
  String language;

  Result({
    required this.category,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.slug,
    required this.publish,
    required this.getImageMediumUrl,
    required this.numberOfViews,
    required this.language,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: Category.fromJson(json["category"]),
        title: json["title"],
        shortDescription: json["short_description"],
        description: json["description"],
        slug: json["slug"],
        publish: DateTime.parse(json["publish"]),
        getImageMediumUrl: json["get_image_medium_url"],
        numberOfViews: json["number_of_views"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "title": title,
        "short_description": shortDescription,
        "description": description,
        "slug": slug,
        "publish": publish.toIso8601String(),
        "get_image_medium_url": getImageMediumUrl,
        "number_of_views": numberOfViews,
        "language": language,
      };
}

class Category {
  int id;
  String name;
  String slug;
  String color;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "color": color,
      };
}
