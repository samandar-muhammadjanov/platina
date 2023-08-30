import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/bloc/article/article_bloc.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/presentation/widgets/shader.dart';
import 'package:platina/utils/colors.dart';

class Articles extends StatelessWidget {
  const Articles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(16), color: white),
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
                  Text(
                    "articles".tr(),
                    style: TextStyle(
                      color: kprimaryColor,
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
          BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state is ArticleError) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is ArticleLoaded) {
                return buildBody(state, context);
              } else {
                return const ShaderContainer(height: 240);
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildBody(ArticleLoaded state, BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = state.articles.results[index];
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
                          "https://cp.dev.platina.uz${item.imageMedium}",
                          height: 240,
                          fit: BoxFit.cover,
                          width: double.infinity,
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
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: state.articles.results.length > 4
            ? 4
            : state.articles.results.length);
  }
}
