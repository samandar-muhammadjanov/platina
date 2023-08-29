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
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = state.results[index];
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
                                    item.publish.timePassedFromNow(),
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
              },
              separatorBuilder: (context, index) => const Divider(
                    height: 15,
                  ),
              itemCount: state.results.length),
        ],
      ),
    );
  }
}
