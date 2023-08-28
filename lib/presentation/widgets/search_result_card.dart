import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:platina/domain/models/search_results.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/utils/colors.dart';
import 'package:platina/utils/extantions.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({super.key, required this.state});
  final SearchResult state;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: List.generate(
                state.results.isEmpty
                    ? state.results.length
                    : state.results.length * 2 - 1, (index) {
              final itemIndex = index ~/ 2;
              final item = state.results[itemIndex];
              final date = item.publish.timePassedFromNow();
              if (index.isOdd) {
                return const Divider(
                  height: 15,
                ); // Adds a divider for odd indices
              }
              return InkWell(
                onTap: () {
                  Navigator.push(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Image.network(
                          "https://cp.dev.platina.uz/${item.getImageMediumUrl}",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              // print(state.posts.next.split("=").last);
              // if (state is MainPostLoaded) {
              //   context.read<MainPostBloc>().add(
              //         GetMainPosts(
              //             state.posts.next.split("=").last),
              //       );
              // }

              // print(state.posts.next);
            },
            child: Container(
              height: 41,
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: kbackground),
              child: Text(
                "Яна юклаш",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: kprimaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
