import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/domain/models/news_detail.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/utils/colors.dart';

class NextAndPrevPosts extends StatelessWidget {
  const NextAndPrevPosts({
    super.key,
    required this.nextPost,
    required this.prevPost,
  });

  final NextPost nextPost;
  final PrevPost prevPost;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nextPost.id == 0
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(
                          year: DateFormat("yyyy").format(nextPost.publish),
                          month: DateFormat("MM").format(nextPost.publish),
                          day: DateFormat("dd").format(nextPost.publish),
                          slug: nextPost.slug,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 94,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nextPost.title,
                                maxLines: 3,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: kprimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 132,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                decoration: BoxDecoration(
                                  color: kbackground,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/svg/Arrow_Left_XLL.svg"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "prevNews".tr(),
                                      style: TextStyle(
                                        color: kprimaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "https://cp.dev.platina.uz/${nextPost.imageSmall}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
          nextPost.id == 0
              ? const SizedBox()
              : const Divider(
                  height: 30,
                ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(
                    year: DateFormat("yyyy").format(prevPost.publish),
                    month: DateFormat("MM").format(prevPost.publish),
                    day: DateFormat("dd").format(prevPost.publish),
                    slug: prevPost.slug,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 94,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prevPost.title,
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: kprimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: 132,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: kbackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "nextNews".tr(),
                                style: TextStyle(
                                  color: kprimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset("assets/svg/Arrow_Right_XL.svg"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "https://cp.dev.platina.uz/${prevPost.imageSmall}",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
