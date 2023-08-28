// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/domain/models/search_results.dart';
import 'package:platina/presentation/pages/article_page.dart';
import 'package:platina/presentation/pages/home_page.dart';
import 'package:platina/presentation/pages/lenta_page.dart';
import 'package:platina/presentation/pages/popular_page.dart';
import 'package:platina/presentation/pages/video-page.dart';
import 'package:platina/presentation/widgets/category.dart';
import 'package:platina/presentation/widgets/drawer.dart';
import 'package:platina/presentation/widgets/search.dart';
import 'package:platina/presentation/widgets/search_result.dart';
import 'package:platina/utils/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
// drawer ochilishi uchun funktsiya
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }
// Qidirish panelini ochish uchun funktsiya
  bool _isSearchOpen = false;
  void _toogleSearch() {
    setState(() {
      _isSearchOpen = !_isSearchOpen;
    });
  }

// Drawerda bironta menu tanlansa dashboardan body o'zgarishi uchun
  bool isMenuClicked = false;
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

  List pages = [
    const HomePage(),
    const LentaPage(),
    const PopularPage(),
    const ArticlePage(),
    const VideoPage(),
  ];
  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          if (!isSearchResultClicked) ...{
            if (!isMenuClicked) pages[currentIndex] else const Categories(),
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
                    isMenuClicked = false;
                    isSearchResultClicked = false;
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
