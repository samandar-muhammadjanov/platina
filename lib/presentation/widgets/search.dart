import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/domain/models/search_results.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/utils/colors.dart';

class AppSearch extends StatefulWidget {
  const AppSearch({
    super.key,
    required this.isSearch,
    required this.toogleSearch,
    required this.searchResult,
  });
  final bool isSearch;
  final Function() toogleSearch;
  final Function(bool, String, SearchResult) searchResult;

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.isSearch) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: kprimaryColor.withOpacity(.6),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTap: widget.toogleSearch,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 16, right: 16, bottom: 10),
                    child: TextField(
                      onChanged: (value) {
                        context.read<SearchBloc>().add(
                              GetSearchResults(searchController.text),
                            );
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12),
                        filled: true,
                        fillColor: white,
                        hintText: "Сайт бўйлаб қидирув...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: kLinkColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state is SearchLoaded) ...{
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.searchResult.results.length > 4
                                  ? 4
                                  : state.searchResult.results.length,
                              itemBuilder: (context, index) {
                                final item = state.searchResult.results[index];
                                return ListTile(
                                  onTap: () async {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewsDetailPage(
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
                                  minLeadingWidth: 0,
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      "https://cp.dev.platina.uz${item.getImageMediumUrl}",
                                      width: 36,
                                      height: 36,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    item.title,
                                    style: TextStyle(
                                        color: kprimaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              onTap: () {
                                widget.searchResult(true, searchController.text,
                                    state.searchResult);
                                widget.toogleSearch();
                              },
                              minLeadingWidth: 0,
                              leading: SvgPicture.asset(
                                  "assets/svg/search_result.svg"),
                              title: Text(
                                "Қидирув натижаларига ўтиш",
                                style: TextStyle(
                                    color: kprimaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  }
                ],
              );
            },
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
