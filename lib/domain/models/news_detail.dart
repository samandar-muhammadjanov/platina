import 'dart:convert';

NewsDetail newsDetailFromJson(String str) =>
    NewsDetail.fromJson(json.decode(str));

String newsDetailToJson(NewsDetail data) => json.encode(data.toJson());

class NewsDetail {
  PostDetail postDetail;
  List<dynamic> similarPosts;
  List<dynamic> toTranslate;
  NextPost nextPost;
  PrevPost prevPost;

  NewsDetail({
    required this.postDetail,
    required this.similarPosts,
    required this.toTranslate,
    required this.nextPost,
    required this.prevPost,
  });

  factory NewsDetail.fromJson(Map<String, dynamic> json) => NewsDetail(
        postDetail: PostDetail.fromJson(json["post_detail"]),
        similarPosts: List<dynamic>.from(json["similar_posts"].map((x) => x)),
        toTranslate: List<dynamic>.from(json["to_translate"].map((x) => x)),
        nextPost: NextPost.fromJson(json["next_post"]),
        prevPost: PrevPost.fromJson(json["prev_post"]),
      );

  Map<String, dynamic> toJson() => {
        "post_detail": postDetail.toJson(),
        "similar_posts": List<dynamic>.from(similarPosts.map((x) => x)),
        "to_translate": List<dynamic>.from(toTranslate.map((x) => x)),
        "next_post": nextPost.toJson(),
        "prev_post": prevPost.toJson(),
      };
}

class NextPost {
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
  dynamic expiredAt;
  String language;

  NextPost({
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

  factory NextPost.fromJson(Map<String, dynamic> json) => NextPost(
        id: json["id"] ?? 0,
        category: Category.fromJson(json["category"] ?? {}),
        title: json["title"],
        shortDescription: json["short_description"],
        relatesTo: json["relates_to"] ?? "",
        description: json["description"] ?? "",
        slug: json["slug"],
        authorOffered: json["author_offered"],
        publish: DateTime.parse(json["publish"] ?? "2023-08-17T10:34:15+05:00"),
        isPinned: json["is_pinned"],
        numberOfViews: json["number_of_views"] ?? 0,
        image: json["image"] ?? "",
        imageExtraLarge: json["image_extra_large"] ?? "",
        imageLarge: json["image_large"] ?? "",
        imageMedium: json["image_medium"] ?? "",
        imageSmall: json["image_small"] ?? "",
        imageSource: json["image_source"] ?? "",
        imageName: json["image_name"] ?? "",
        gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
        shortUrl: json["short_url"] ?? "",
        youtubeLink: json["youtube_link"] ?? "",
        tags: List<String>.from(json["tags"].map((x) => x)),
        expiredAt: json["expired_at"] ?? "",
        language: json["language"] ?? "",
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
        "expired_at": expiredAt,
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
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      color: json["color"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "color": color,
      };
}

class PostDetail {
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
  dynamic expiredAt;
  String language;

  PostDetail({
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

  factory PostDetail.fromJson(Map<String, dynamic> json) => PostDetail(
        id: json["id"] ?? 0,
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
        youtubeLink: json["youtube_link"] ?? "",
        tags: List<String>.from(json["tags"].map((x) => x)),
        expiredAt: json["expired_at"],
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
        "expired_at": expiredAt,
        "language": language,
      };
}

class PrevPost {
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
  dynamic expiredAt;
  String language;

  PrevPost({
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

  factory PrevPost.fromJson(Map<String, dynamic> json) => PrevPost(
        id: json["id"] ?? 0,
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
        youtubeLink: json["youtube_link"] ?? "",
        tags: List<String>.from(json["tags"].map((x) => x)),
        expiredAt: json["expired_at"],
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
        "expired_at": expiredAt,
        "language": language,
      };
}
