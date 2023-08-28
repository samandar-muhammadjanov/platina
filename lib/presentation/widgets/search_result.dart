import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/domain/models/search_results.dart';
import 'package:platina/presentation/widgets/business.dart';
import 'package:platina/presentation/widgets/currency.dart';
import 'package:platina/presentation/widgets/footer.dart';
import 'package:platina/presentation/widgets/search_filter.dart';
import 'package:platina/presentation/widgets/search_result_card.dart';
import 'package:platina/utils/colors.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget(
      {super.key, required this.query, required this.result});
  final String query;
  final SearchResult result;
  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  bool isNewest = true;
  bool isPopular = false;
  void _toogleNewest() {
    setState(() {
      isNewest = !isNewest;
    });
  }

  void _tooglePopular() {
    setState(() {
      isPopular = !isPopular;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Currency(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.query,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: kprimaryColor),
                    ),
                    Text("Қидирув натижалари: ${widget.result.count} та"),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: _toogleNewest,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: isNewest ? white : null,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: isNewest
                                          ? [
                                              BoxShadow(
                                                  offset: const Offset(0, 6),
                                                  color: kprimaryColor
                                                      .withOpacity(0.12),
                                                  blurRadius: 12,
                                                  spreadRadius: -6)
                                            ]
                                          : null),
                                  child: const Text("Янги хабарлар"),
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              InkWell(
                                onTap: _tooglePopular,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: isPopular ? white : null,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: isPopular
                                          ? [
                                              BoxShadow(
                                                  offset: const Offset(0, 6),
                                                  color: kprimaryColor
                                                      .withOpacity(0.12),
                                                  blurRadius: 12,
                                                  spreadRadius: -6)
                                            ]
                                          : null),
                                  child: const Text("Оммабоп"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return const Filter();
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 6),
                                      color: kprimaryColor.withOpacity(0.12),
                                      blurRadius: 12,
                                      spreadRadius: -6)
                                ]),
                            child: SvgPicture.asset("assets/svg/filter.svg"),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              widget.result.results.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Сўровингиз бўйича натижалар топилмади.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kprimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  : SearchResultCard(
                      state: widget.result,
                    )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Business(),
          const Footer(),
        ],
      ),
    );
  }
}
