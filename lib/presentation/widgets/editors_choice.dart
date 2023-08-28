import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/utils/colors.dart';
import 'package:platina/utils/extantions.dart';
import 'shader.dart';

class EditorsChoice extends StatelessWidget {
  const EditorsChoice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(16), color: white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/svg/polygon.svg"),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Муҳаррир танлови",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset("assets/svg/Arrow_Left_XL.svg")
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<AuthorsBloc, AuthorsState>(
            builder: (context, state) {
              if (state is AuthorsInitial) {
                return const ShaderContainer(height: 190);
              } else if (state is AuthorsLoading) {
                return const ShaderContainer(height: 190);
              } else if (state is AuthorsLoaded) {
                return body(state);
              } else if (state is AuthorsError) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const ShaderContainer(height: 190);
              }
            },
          )
        ],
      ),
    );
  }

  SizedBox body(AuthorsLoaded state) {
    return SizedBox(
      height: 292,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(
          width: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: state.posts.results.length,
        itemBuilder: (context, index) {
          final item = state.posts.results[index];
          final date = item.publish.timePassedFromNow();
          return InkWell(
            onTap: () {
              Navigator.pushReplacement(
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
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      "https://cp.dev.platina.uz${item.imageMedium}",
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    item.title,
                    maxLines: 2,
                    style: TextStyle(
                        color: kprimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        item.category.name,
                        style: TextStyle(
                            color: item.category.color.toColor().withOpacity(1),
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
          );
        },
      ),
    );
  }
}
