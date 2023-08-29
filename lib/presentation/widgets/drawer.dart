// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/widgets/shader.dart';
import 'package:platina/presentation/widgets/social_media.dart';
import 'package:platina/utils/colors.dart';
import 'package:platina/utils/extantions.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer(
      {super.key,
      required this.isDrawerOpen,
      required this.toogleDrawer,
      required this.menu});
  final bool isDrawerOpen;
  final Function() toogleDrawer;
  Function(bool) menu;
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List categories = [
    'Сиёсат',
    'Иқтисод',
    'Жаҳон',
    'Жамият',
    'Таҳлил',
    'Спорт',
    'Давлат Харидлари',
    'Мақола',
  ];
  List languages = ["Ўзб", "O’zb", "Рус", 'Eng'];
  int currentMenu = 1000;
  int currentLanguage = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.isDrawerOpen) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: kprimaryColor.withOpacity(.6),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTap: widget.toogleDrawer,
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width * 0.67,
            child: SizedBox(
              height: size(context).height - AppBar().preferredSize.height,
              child: Drawer(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        BlocBuilder<MenuBloc, MenuState>(
                          builder: (context, state) {
                            if (state is MenuError) {
                              return const SizedBox();
                            } else if (state is MenuLoaded) {
                              return buildCategories(state);
                            } else {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return const ShaderContainer(height: 44);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: 7);
                            }
                          },
                        ),
                        const Divider(
                          height: 30,
                        ),
                        Row(
                          children: List.generate(
                            languages.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentLanguage = index;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: currentLanguage == index
                                            ? const Color(0xffF8F8FF)
                                            : white),
                                    child: Text(
                                      languages[index],
                                      style: TextStyle(
                                          color: kprimaryColor,
                                          fontWeight: currentLanguage == index
                                              ? FontWeight.w700
                                              : FontWeight.w500),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(
                          height: 30,
                        ),
                        Row(
                          children: [
                            socialMedias(
                                "assets/svg/telegram.svg", "platinauzb"),
                            const SizedBox(
                              width: 10,
                            ),
                            socialMedias(
                                "assets/svg/instagram.svg", "platinauzb"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            socialMedias(
                                "assets/svg/facebook.svg", "platinauz"),
                            const SizedBox(
                              width: 10,
                            ),
                            socialMedias("assets/svg/youtube.svg", "platinauz"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            socialMedias("assets/svg/twitter.svg", "platinauz"),
                            const SizedBox(
                              width: 10,
                            ),
                            socialMedias("assets/svg/tiktok.svg", "platinauz"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildCategories(MenuLoaded state) {
    return Column(
      children: List.generate(state.categories.length * 2 - 1, (index) {
        final itemIndex = index ~/ 2;
        final item = state.categories[itemIndex];

        if (index.isOdd) {
          return const SizedBox(
            height: 10,
          ); // Adds a divider for odd indices
        }
        return InkWell(
          onTap: () {
            setState(() {
              currentMenu = index;
            });
            widget.menu(true);
            widget.toogleDrawer();
            context.read<PostByCategoryBloc>().add(
                  GetPostsByCategoryEvent(
                      item.slug == "ozbekiston" ? "siyosat" : item.slug),
                );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: currentMenu == index
                    ? item.color.toColor().withOpacity(0.1)
                    : null,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/polygon.svg",
                  color: currentMenu == index
                      ? item.color.toColor().withOpacity(1)
                      : kDisactiveMenu,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  item.name,
                  style: TextStyle(
                    color: kprimaryColor,
                    fontWeight: currentMenu == index
                        ? FontWeight.w700
                        : FontWeight.w500,
                    fontSize: 17,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
