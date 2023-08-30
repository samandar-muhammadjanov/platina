import 'package:easy_localization/easy_localization.dart';
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

class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: kprimaryColor,
            onRefresh: () async {
              if (state is PopularPostsLoaded) {
                context.read<PostsBloc>().add(GetPopularPosts());
              }
            },
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Currency(),
                    const SizedBox(
                      height: 10,
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
                                  SvgPicture.asset("assets/svg/polygon.svg"),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "popularNews".tr(),
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
                          const Divider(
                            height: 20,
                          ),
                          BlocBuilder<PostsBloc, PostsState>(
                            builder: (context, state) {
                              if (state is PopularPostsLoaded) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final item =
                                              state.posts.results[index];
                                          final date =
                                              item.publish.timePassedFromNow();
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailPage(
                                                    year: DateFormat("yyyy")
                                                        .format(item.publish),
                                                    month: DateFormat("MM")
                                                        .format(item.publish),
                                                    day: DateFormat("dd")
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          item.title,
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                              color:
                                                                  kprimaryColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        Text(
                                                          date,
                                                          style: TextStyle(
                                                              color:
                                                                  kGreyTextColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                        itemCount: state.posts.results.length),
                                    SizedBox(
                                      height: state.posts.next == null ? 0 : 15,
                                    ),
                                    if (isLoading) ...{
                                      ListView.builder(
                                        itemBuilder: (context, index) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ShaderContainer(
                                                    height: 15,
                                                    width: size(context).width *
                                                        0.5,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  ShaderContainer(
                                                    height: 15,
                                                    width: size(context).width *
                                                        0.6,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  ShaderContainer(
                                                    height: 15,
                                                    width: size(context).width *
                                                        0.3,
                                                  ),
                                                ],
                                              ),
                                              ShaderContainer(
                                                height: 86,
                                                width:
                                                    size(context).width * 0.25,
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    },
                                    state.posts.next == null
                                        ? const SizedBox()
                                        : InkWell(
                                            onTap: () async {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              await Future.delayed(
                                                const Duration(seconds: 1),
                                                () {
                                                  context.read<PostsBloc>().add(
                                                      GetMorePopularPosts());
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 41,
                                              alignment: Alignment.center,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: kbackground),
                                              child: Text(
                                                "loadMore".tr(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: kprimaryColor),
                                              ),
                                            ),
                                          )
                                  ],
                                );
                              } else {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ShaderContainer(
                                          height: 15,
                                          width: size(context).width * 0.5,
                                        ),
                                        const SizedBox(height: 5),
                                        ShaderContainer(
                                          height: 15,
                                          width: size(context).width * 0.6,
                                        ),
                                        const SizedBox(height: 5),
                                        ShaderContainer(
                                          height: 15,
                                          width: size(context).width * 0.3,
                                        ),
                                      ],
                                    ),
                                    ShaderContainer(
                                      height: 86,
                                      width: size(context).width * 0.25,
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Business(),
                    const SizedBox(height: 20),
                    const Footer()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
