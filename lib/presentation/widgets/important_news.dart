import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/presentation/widgets/shader.dart';
import 'package:platina/utils/colors.dart';
import 'package:platina/utils/extantions.dart';

class ImportantNews extends StatelessWidget {
  const ImportantNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPostBloc, MainPostState>(
      builder: (context, state) {
        if (state is MainPostError) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is MainPostLoaded) {
          if (state.posts.results.isEmpty) {
            return const SizedBox();
          }
          return Container(
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
                          "Муҳим янгиликлар",
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
                buildBody(state, context)
              ],
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: ShaderContainer(height: 240),
          );
        }
      },
    );
  }

  Column buildBody(MainPostLoaded state, BuildContext context) {
    return Column(
      children: List.generate(
        state.posts.results.isEmpty
            ? state.posts.results.length
            : state.posts.results.length * 2 - 1,
        (index) {
          final itemIndex = index ~/ 2;
          final item = state.posts.results[itemIndex];
          final date = item.publish.timePassedFromNow();
          if (index.isOdd) {
            return const Divider(
              height: 15,
            ); // Adds a divider for odd indices
          }
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailPage(
                      year: DateFormat("yyyy").format(item.publish),
                      month: DateFormat("MM").format(item.publish),
                      day: DateFormat("dd").format(item.publish),
                      slug: item.slug,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            "https://cp.dev.platina.uz/${item.imageMedium}",
                            height: 240,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 240,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                kprimaryColor.withAlpha(200),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                                kprimaryColor.withAlpha(200),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/logo.svg",
                                color: white,
                                width: 80,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/telegram.svg",
                                    color: white,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "@platinauzb",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              item.title,
                              maxLines: 2,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    item.title,
                    maxLines: 2,
                    style: TextStyle(
                        color: kprimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    item.shortDescription.removeHtmlTags(),
                    maxLines: 2,
                    style: TextStyle(
                      color: kGreyTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "давомини ўқиш",
                    style: TextStyle(
                        color: kLinkColor, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        item.category.name,
                        style: TextStyle(
                            color: kSourceColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        date,
                        style: TextStyle(
                            color: kGreyTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailPage(
                      year: DateFormat("yyyy").format(item.publish),
                      month: DateFormat("MM").format(item.publish),
                      day: DateFormat("dd").format(item.publish),
                      slug: item.slug,
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 86,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title,
                            maxLines: 3,
                            style: TextStyle(
                                color: kprimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [
                              Text(
                                item.category.name,
                                style: TextStyle(
                                    color: item.category.color
                                        .toColor()
                                        .withOpacity(1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Text(
                                date,
                                style: TextStyle(
                                    color: kGreyTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 129,
                        height: 86,
                        child: Stack(
                          children: [
                            Image.network(
                              "https://cp.dev.platina.uz${item.imageMedium}",
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    kprimaryColor.withAlpha(200),
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    kprimaryColor.withAlpha(200),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/logo.svg",
                                    color: white,
                                    width: 30,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/telegram.svg",
                                        color: white,
                                        width: 8,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "@platinauzb",
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  item.title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
