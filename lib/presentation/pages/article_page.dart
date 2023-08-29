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

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: kprimaryColor,
            onRefresh: () async {
              if (state is ArticleLoaded) {
                context.read<ArticleBloc>().add(GetArticlesEvent());
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
                    BlocBuilder<ArticleBloc, ArticleState>(
                      builder: (context, state) {
                        if (state is ArticleLoaded) {
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
                                            "assets/svg/polygon.svg"),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Мақолалар",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: kprimaryColor,
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
                                buildBody(state),
                                SizedBox(
                                  height: state.articles.next.isEmpty ? 0 : 15,
                                ),
                                if (isLoading) ...{
                                  ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 10,
                                    ),
                                    itemCount: 10,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const ShaderContainer(height: 240),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          const ShaderContainer(height: 15),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          ShaderContainer(
                                            height: 15,
                                            width: size(context).width * 0.8,
                                          )
                                        ],
                                      );
                                    },
                                  )
                                },
                                state.articles.next.isEmpty
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () async {
                                          setState(() {
                                            isLoading = true;
                                          });

                                          context
                                              .read<ArticleBloc>()
                                              .add(GetMoreArticlesEvent());
                                          await Future.delayed(
                                            const Duration(seconds: 3),
                                            () {
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
                                            "Яна юклаш",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: kprimaryColor),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const ShaderContainer(height: 240),
                              const SizedBox(
                                height: 16,
                              ),
                              const ShaderContainer(height: 15),
                              const SizedBox(
                                height: 5,
                              ),
                              ShaderContainer(
                                height: 15,
                                width: size(context).width * 0.3,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const ShaderContainer(height: 240),
                              const SizedBox(
                                height: 16,
                              ),
                              const ShaderContainer(height: 15),
                              const SizedBox(
                                height: 5,
                              ),
                              ShaderContainer(
                                height: 15,
                                width: size(context).width * 0.3,
                              ),
                            ],
                          );
                        }
                      },
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

  Widget buildBody(ArticleLoaded state) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = state.articles.results[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(
                    year: DateFormat("yyyy").format(item.publish),
                    month: DateFormat("M").format(item.publish),
                    day: DateFormat("ddd").format(item.publish),
                    slug: item.slug,
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
                    "https://cp.dev.platina.uz${item.imageMedium}",
                    height: 240,
                    fit: BoxFit.cover,
                    width: double.infinity,
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
        separatorBuilder: (context, index) => const Divider(
              height: 20,
            ),
        itemCount: state.articles.results.length);
  }
}
