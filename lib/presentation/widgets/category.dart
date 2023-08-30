import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/presentation/widgets/business.dart';
import 'package:platina/presentation/widgets/currency.dart';
import 'package:platina/presentation/widgets/footer.dart';
import 'package:platina/presentation/widgets/shader.dart';
import 'package:platina/utils/colors.dart';
import 'package:platina/utils/extantions.dart';
import 'package:shimmer/shimmer.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostByCategoryBloc, PostByCategoryState>(
        builder: (context, state) {
          if (state is PostByCategoryError) {
            return Text(state.error);
          } else if (state is PostByCategoryLoaded) {
            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Currency(),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<PostByCategoryBloc, PostByCategoryState>(
                      builder: (context, state) {
                        print(state);
                        if (state is PostByCategoryLoaded) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/svg/polygon.svg",
                                            color: state.post.results.first
                                                .category.color
                                                .toColor()
                                                .withOpacity(1)),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          state.post.results[0].category.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                        "assets/svg/Arrow_Left_XL.svg")
                                  ],
                                ),
                                const Divider(
                                  height: 20,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final item = state.post.results[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NewsDetailPage(
                                                year: DateFormat("yyyy")
                                                    .format(item.publish),
                                                month: DateFormat("M")
                                                    .format(item.publish),
                                                day: DateFormat("ddd")
                                                    .format(item.publish),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      item.title,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color: kprimaryColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      item.publish
                                                          .timePassedFromNow(),
                                                      style: TextStyle(
                                                          color: kGreyTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  "https://cp.dev.platina.uz/${item.imageSmall}",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                          height: 15,
                                        ),
                                    itemCount: state.post.results.length),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 41,
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: kbackground),
                                  child: Text(
                                    "Яна юклаш",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: kprimaryColor),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Business(),
                    const SizedBox(height: 20),
                    const Footer(),
                  ],
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Currency(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: SvgPicture.asset(
                                    "assets/svg/polygon.svg",
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                ShaderContainer(
                                  height: 15,
                                  width: size(context).width * 0.2,
                                )
                              ],
                            ),
                            Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: SvgPicture.asset(
                                    "assets/svg/Arrow_Left_XL.svg"))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShaderContainer(
                                      height: 15,
                                      width: size(context).width * 0.4,
                                    ),
                                    const SizedBox(height: 5),
                                    ShaderContainer(
                                      height: 15,
                                      width: size(context).width * 0.5,
                                    ),
                                    const SizedBox(height: 5),
                                    ShaderContainer(
                                      height: 15,
                                      width: size(context).width * 0.3,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                ShaderContainer(
                                  height: 86,
                                  width: size(context).width * 0.33,
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Business(),
                  SizedBox(height: 20),
                  Footer(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
