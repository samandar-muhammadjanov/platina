import 'dart:convert';

List<BusinessPosts> businessPostsFromJson(String str) =>
    List<BusinessPosts>.from(
        json.decode(str).map((x) => BusinessPosts.fromJson(x)));

String businessPostsToJson(List<BusinessPosts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusinessPosts {
  int id;
  Category category;
  String title;
  String shortDescription;
  dynamic relatesTo;
  String description;
  String slug;
  bool authorOffered;
  DateTime publish;
  bool isPinned;
  int numberOfViews;
  String image;
  String imageExtraLarge;
  String imageLarge;
  String imageMedium;
  String imageSmall;
  String imageSource;
  String imageName;
  List<dynamic> gallery;
  String shortUrl;
  dynamic youtubeLink;
  List<String> tags;
  DateTime expiredAt;
  String language;

  BusinessPosts({
    required this.id,
    required this.category,
    required this.title,
    required this.shortDescription,
    required this.relatesTo,
    required this.description,
    required this.slug,
    required this.authorOffered,
    required this.publish,
    required this.isPinned,
    required this.numberOfViews,
    required this.image,
    required this.imageExtraLarge,
    required this.imageLarge,
    required this.imageMedium,
    required this.imageSmall,
    required this.imageSource,
    required this.imageName,
    required this.gallery,
    required this.shortUrl,
    required this.youtubeLink,
    required this.tags,
    required this.expiredAt,
    required this.language,
  });

  factory BusinessPosts.fromJson(Map<String, dynamic> json) => BusinessPosts(
        id: json["id"],
        category: Category.fromJson(json["category"]),
        title: json["title"],
        shortDescription: json["short_description"],
        relatesTo: json["relates_to"],
        description: json["description"],
        slug: json["slug"],
        authorOffered: json["author_offered"],
        publish: DateTime.parse(json["publish"]),
        isPinned: json["is_pinned"],
        numberOfViews: json["number_of_views"],
        image: json["image"],
        imageExtraLarge: json["image_extra_large"],
        imageLarge: json["image_large"],
        imageMedium: json["image_medium"],
        imageSmall: json["image_small"],
        imageSource: json["image_source"],
        imageName: json["image_name"],
        gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
        shortUrl: json["short_url"],
        youtubeLink: json["youtube_link"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        expiredAt: DateTime.parse(json["expired_at"]),
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category.toJson(),
        "title": title,
        "short_description": shortDescription,
        "relates_to": relatesTo,
        "description": description,
        "slug": slug,
        "author_offered": authorOffered,
        "publish": publish.toIso8601String(),
        "is_pinned": isPinned,
        "number_of_views": numberOfViews,
        "image": image,
        "image_extra_large": imageExtraLarge,
        "image_large": imageLarge,
        "image_medium": imageMedium,
        "image_small": imageSmall,
        "image_source": imageSource,
        "image_name": imageName,
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "short_url": shortUrl,
        "youtube_link": youtubeLink,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "expired_at": expiredAt.toIso8601String(),
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
