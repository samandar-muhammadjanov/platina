// To parse this JSON data, do
//
//     final menues = menuesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Menues> menuesFromJson(String str) => List<Menues>.from(json.decode(str).map((x) => Menues.fromJson(x)));

String menuesToJson(List<Menues> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menues {
    String name;
    String slug;
    String color;
    int order;
    String link;
    String language;

    Menues({
        required this.name,
        required this.slug,
        required this.color,
        required this.order,
        required this.link,
        required this.language,
    });

    factory Menues.fromJson(Map<String, dynamic> json) => Menues(
        name: json["name"],
        slug: json["slug"],
        color: json["color"],
        order: json["order"],
        link: json["link"],
        language: json["language"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "color": color,
        "order": order,
        "link": link,
        "language": language,
    };
}
