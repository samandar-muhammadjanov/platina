import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/domain/models/search_results.dart';
import 'package:platina/presentation/pages/article_page.dart';
import 'package:platina/presentation/pages/home_page.dart';
import 'package:platina/presentation/pages/lenta_page.dart';
import 'package:platina/presentation/pages/popular_page.dart';
import 'package:platina/presentation/widgets/category.dart';
import 'package:platina/presentation/widgets/post_redirect.dart';
import 'package:platina/presentation/pages/video-page.dart';
import 'package:platina/presentation/widgets/business.dart';
import 'package:platina/presentation/widgets/currency.dart';
import 'package:platina/presentation/widgets/drawer.dart';
import 'package:platina/presentation/widgets/footer.dart';
import 'package:platina/presentation/widgets/search.dart';
import 'package:platina/presentation/widgets/search_result.dart';
import 'package:platina/utils/colors.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage(
      {super.key,
      required this.year,
      required this.month,
      required this.day,
      required this.slug});
  final String year;
  final String month;
  final String day;
  final String slug;
  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  bool _isSearchOpen = false;
  void _toogleSearch() {
    setState(() {
      _isSearchOpen = !_isSearchOpen;
    });
  }

  void _updateMenu(bool isMenuClicked) {
    setState(() {
      this.isMenuClicked = isMenuClicked;
    });
  }

// Qidirish tizimidan kelgan ma'lumotni body da chiqarish uchun funktsiya

  bool isSearchResultClicked = false;
  String query = '';
  SearchResult? result;
  void _showSearchResult(
      bool isSearchResultClicked, String query, SearchResult result) {
    setState(() {
      this.isSearchResultClicked = isSearchResultClicked;
      this.query = query;
      this.result = result;
    });
  }

  bool isMenuClicked = false;
  int currentIndex = 0;
  bool isIconsClicked = false;

  @override
  Widget build(BuildContext context) {
    List pages = [
      const HomePage(),
      const LentaPage(),
      const PopularPage(),
      const ArticlePage(),
      const VideoPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          "assets/svg/logo.svg",
          color: kprimaryColor,
        ),
        leading: GestureDetector(
            onTap: () {
              _toggleDrawer();
            },
            child: SvgPicture.asset("assets/svg/menu.svg")),
        actions: [
          GestureDetector(
              onTap: () {
                _toogleSearch();
              },
              child: SvgPicture.asset("assets/svg/search.svg")),
        ],
      ),
      body: isIconsClicked
          ? Stack(
              children: [
                pages[currentIndex],
                AppDrawer(
                    isDrawerOpen: _isDrawerOpen,
                    toogleDrawer: _toggleDrawer,
                    menu: _updateMenu),
                AppSearch(
                  isSearch: _isSearchOpen,
                  toogleSearch: _toogleSearch,
                  searchResult: _showSearchResult,
                )
              ],
            )
          : Stack(
              children: [
                if (!isSearchResultClicked) ...{
                  if (!isMenuClicked)
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const Currency(),
                          const SizedBox(
                            height: 20,
                          ),
                          PostRedirect(
                            year: widget.year,
                            month: widget.month,
                            day: widget.day,
                            slug: widget.slug,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Business(),
                          const SizedBox(
                            height: 20,
                          ),
                          const Footer()
                        ],
                      ),
                    )
                  else
                    const Categories()
                } else ...{
                  SearchResultWidget(
                    query: query,
                    result: result!,
                  )
                },
                AppDrawer(
                    isDrawerOpen: _isDrawerOpen,
                    toogleDrawer: _toggleDrawer,
                    menu: _updateMenu),
                AppSearch(
                  isSearch: _isSearchOpen,
                  toogleSearch: _toogleSearch,
                  searchResult: _showSearchResult,
                )
              ],
            ),
      bottomNavigationBar: _isDrawerOpen || _isSearchOpen
          ? null
          : SizedBox(
              height: 60,
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                    isIconsClicked = true;
                  });
                },
                selectedItemColor: kprimaryColor,
                unselectedItemColor: kGreyTextColor,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/home.svg"),
                    activeIcon: SvgPicture.asset(
                      "assets/svg/home.svg",
                      color: kprimaryColor,
                    ),
                    label: "Асосий",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/News.svg"),
                    activeIcon: SvgPicture.asset(
                      "assets/svg/News.svg",
                      color: kprimaryColor,
                    ),
                    label: "Лента",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/Trending_Up.svg"),
                    activeIcon: SvgPicture.asset(
                      "assets/svg/Trending_Up.svg",
                      color: kprimaryColor,
                    ),
                    label: "Оммабоп",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/File_Document.svg"),
                    activeIcon: SvgPicture.asset(
                      "assets/svg/File_Document.svg",
                      color: kprimaryColor,
                    ),
                    label: "Мақола",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/Play_Circle.svg"),
                    activeIcon: SvgPicture.asset(
                      "assets/svg/Play_Circle.svg",
                      color: kprimaryColor,
                    ),
                    label: "Видео",
                  ),
                ],
              ),
            ),
    );
  }
}
