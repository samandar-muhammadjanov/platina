import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/widgets/business.dart';
import 'package:platina/presentation/widgets/currency.dart';
import 'package:platina/presentation/widgets/footer.dart';
import 'package:platina/utils/colors.dart';
import 'package:platina/utils/extantions.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Currency(),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  if (state is PopularPostsLoaded) {
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/svg/polygon.svg"),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    "Оммабоп янгиликлар",
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
                          const Divider(
                            height: 20,
                          ),
                          Column(
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
                              return SizedBox(
                                height: 86,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.title,
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: kprimaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            date,
                                            style: TextStyle(
                                                color: kGreyTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "https://cp.dev.platina.uz/${item.imageSmall}",
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
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
                    return const SizedBox();
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
  }
}
