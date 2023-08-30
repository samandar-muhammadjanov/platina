import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/widgets/shader.dart';
import 'package:platina/presentation/widgets/social_media.dart';
import 'package:platina/utils/colors.dart';
import 'package:platina/utils/extantions.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.showCategory});
  final Function(bool) showCategory;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: size(context).width * 0.65,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              MenuItems(updateMenu: showCategory),
              const Divider(
                height: 30,
              ),
              const LanguageItems(),
              const Divider(
                height: 30,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse("https://t.me/platinauzb"),
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch');
                        }
                      },
                      child: socialMedias(
                          "assets/svg/telegram.svg", "platinauzb")),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse("https://www.instagram.com/platinauzb/"),
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch');
                        }
                      },
                      child: socialMedias(
                          "assets/svg/instagram.svg", "platinauzb")),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse("https://facebook.com/platinauz"),
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch');
                        }
                      },
                      child:
                          socialMedias("assets/svg/facebook.svg", "platinauz")),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse(
                                "https://www.youtube.com/channel/UCwUFCV_nMacMGj_-yD6_Mow"),
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch');
                        }
                      },
                      child:
                          socialMedias("assets/svg/youtube.svg", "platinauz")),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse("https://twitter.com/platinauz"),
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch');
                        }
                      },
                      child:
                          socialMedias("assets/svg/twitter.svg", "platinauz")),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageItems extends StatefulWidget {
  const LanguageItems({
    super.key,
  });

  @override
  State<LanguageItems> createState() => _LanguageItemsState();
}

class _LanguageItemsState extends State<LanguageItems> {
  @override
  Widget build(BuildContext context) {
    bool isUzLatin = context.locale == const Locale("uz", "UZ") ? true : false;
    bool isUzCyril = context.locale ==
        const Locale.fromSubtags(
            languageCode: "uz", scriptCode: "Cyrl", countryCode: "UZ");
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: InkWell(
          onTap: () {
            setState(() {
              isUzLatin = false;
              isUzCyril = true;
              context.setLocale(const Locale.fromSubtags(
                  languageCode: "uz", scriptCode: "Cyrl", countryCode: "UZ"));
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isUzCyril ? const Color(0xffF8F8FF) : white),
            child: Text(
              "Ўзб",
              style: TextStyle(
                  color: kprimaryColor,
                  fontWeight: isUzCyril ? FontWeight.w700 : FontWeight.w500),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: InkWell(
          onTap: () {
            setState(() {
              isUzLatin = true;
              isUzCyril = false;
              context.setLocale(const Locale("uz", "UZ"));
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isUzLatin ? const Color(0xffF8F8FF) : white),
            child: Text(
              "O’zb",
              style: TextStyle(
                  color: kprimaryColor,
                  fontWeight: isUzLatin ? FontWeight.w700 : FontWeight.w500),
            ),
          ),
        ),
      ),
    ]);
  }
}

class MenuItems extends StatefulWidget {
  const MenuItems({super.key, required this.updateMenu});
  final Function(bool) updateMenu;
  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  int currentMenu = 1000;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        if (state is MenuLoaded) {
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
                  widget.updateMenu(true);
                  context.read<PostByCategoryBloc>().add(
                        GetPostsByCategoryEvent(
                            item.slug == "ozbekiston" ? "siyosat" : item.slug),
                      );
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        } else {
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const ShaderContainer(height: 44);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: 7);
        }
      },
    );
  }
}
