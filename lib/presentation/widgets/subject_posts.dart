import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/utils/colors.dart';

class Subject extends StatelessWidget {
  const Subject({
    super.key,
    required this.state,
  });
  final NewsDetailLoaded state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        state.post.similarPosts.isEmpty
            ? const SizedBox()
            : const SizedBox(
                height: 20,
              ),
        state.post.similarPosts.isEmpty
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/svg/polygon.svg"),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "Мавзуга оид",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset("assets/svg/Arrow_Left_XL.svg")
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: List.generate(
                          state.post.similarPosts.length * 2 - 1, (index) {
                        final itemIndex = index ~/ 2;
                        final item = state.post.similarPosts[itemIndex];
                        if (index.isOdd) {
                          return const Divider(
                            height: 30,
                          ); // Adds a divider for odd indices
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailPage(
                                  year: DateFormat("yyyy")
                                      .format(DateTime.parse(item["publish"])),
                                  month: DateFormat("MM")
                                      .format(DateTime.parse(item["publish"])),
                                  day: DateFormat("dd")
                                      .format(DateTime.parse(item["publish"])),
                                  slug: item["slug"],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  "https://cp.dev.platina.uz${item["image_medium"]}",
                                  height: 240,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                item["title"],
                                maxLines: 2,
                                style: TextStyle(
                                    color: kprimaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                ),
              )
      ],
    );
  }
}
