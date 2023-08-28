import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/widgets/shader.dart';
import 'package:platina/presentation/widgets/social_media.dart';
import 'package:platina/utils/colors.dart';
import 'package:platina/utils/extantions.dart';

class AppDrawerTest extends StatefulWidget {
  const AppDrawerTest({super.key, required this.selectMenu});
  final Function(bool) selectMenu;
  @override
  State<AppDrawerTest> createState() => _AppDrawerTestState();
}

class _AppDrawerTestState extends State<AppDrawerTest> {
  List languages = ["Ўзб", "O’zb", "Рус", 'Eng'];
  int currentMenu = 100;
  int currentLanguage = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.67,
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
                    return ListView(
                      shrinkWrap: true,
                      children: const [
                        ShaderContainer(height: 44),
                        SizedBox(
                          height: 5,
                        ),
                        ShaderContainer(height: 44),
                        SizedBox(
                          height: 5,
                        ),
                        ShaderContainer(height: 44),
                        SizedBox(
                          height: 5,
                        ),
                        ShaderContainer(height: 44),
                      ],
                    );
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
                  socialMedias("assets/svg/telegram.svg", "platinauzb"),
                  const SizedBox(
                    width: 10,
                  ),
                  socialMedias("assets/svg/instagram.svg", "platinauzb"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  socialMedias("assets/svg/facebook.svg", "platinauz"),
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
    );
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
            widget.selectMenu(true);
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
