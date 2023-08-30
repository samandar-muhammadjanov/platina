import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/utils/colors.dart';
import 'package:platina/utils/extantions.dart';

class Filter extends StatefulWidget {
  const Filter({
    super.key,
  });

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<int> menues = [];
  bool isNews = false;
  bool isArticles = false;
  bool isByQuery = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      child: Container(
        padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16),
        height: size(context).height - AppBar().preferredSize.height - 25,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "advancedSearch".tr(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kprimaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset("assets/svg/x.svg"),
                  )
                ],
              ),
              BlocBuilder<MenuBloc, MenuState>(
                builder: (context, state) {
                  if (state is MenuLoaded) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final item = state.categories[index];
                        final checkedMenues =
                            menues.any((element) => element == item.order);
                        return ListTile(
                          onTap: () {
                            if (!checkedMenues) {
                              setState(() {
                                menues.add(item.order);
                              });
                            } else {
                              setState(() {
                                menues.remove(item.order);
                              });
                            }
                          },
                          contentPadding: EdgeInsets.zero,
                          minLeadingWidth: 0,
                          leading: Container(
                            width: 18,
                            alignment: Alignment.center,
                            height: 18,
                            decoration: BoxDecoration(
                              color: checkedMenues ? kprimaryColor : null,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: checkedMenues
                                    ? kprimaryColor
                                    : kCheckBoxColor,
                                width: 2,
                              ),
                            ),
                            child: checkedMenues
                                ? Icon(
                                    Icons.check,
                                    color: white,
                                    size: 15,
                                  )
                                : const SizedBox(),
                          ),
                          title: Text(item.name),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              const Divider(
                height: 10,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    isNews = !isNews;
                  });
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: Container(
                  width: 18,
                  alignment: Alignment.center,
                  height: 18,
                  decoration: BoxDecoration(
                    color: isNews ? kprimaryColor : null,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isNews ? kprimaryColor : kCheckBoxColor,
                      width: 2,
                    ),
                  ),
                  child: isNews
                      ? Icon(
                          Icons.check,
                          color: white,
                          size: 15,
                        )
                      : const SizedBox(),
                ),
                title: Text("news".tr()),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    isArticles = !isArticles;
                  });
                },
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: Container(
                  width: 18,
                  alignment: Alignment.center,
                  height: 18,
                  decoration: BoxDecoration(
                    color: isArticles ? kprimaryColor : null,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isArticles ? kprimaryColor : kCheckBoxColor,
                      width: 2,
                    ),
                  ),
                  child: isArticles
                      ? Icon(
                          Icons.check,
                          color: white,
                          size: 15,
                        )
                      : const SizedBox(),
                ),
                title: Text("articles".tr()),
              ),
              const Divider(
                height: 10,
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "publishedDate".tr(),
                style: TextStyle(
                    color: kGreyTextColor, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          suffixIcon: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "from".tr(),
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: kGreyTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8)),
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                  "assets/svg/Calendar_Empty.svg"))),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          suffixIcon: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "until".tr(),
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: kGreyTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8)),
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                  "assets/svg/Calendar_Empty.svg"))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
