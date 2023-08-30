import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/bloc/business_bloc/business_bloc.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/presentation/widgets/shader.dart';
import 'package:platina/utils/colors.dart';

class Business extends StatelessWidget {
  const Business({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
      ),
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
                  Text(
                    "business".tr(),
                    style: TextStyle(
                      fontSize: 18,
                      color: kprimaryColor,
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
          BlocBuilder<BusinessBloc, BusinessState>(
            builder: (context, state) {
              if (state is BusinessError) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is BusinessLoaded) {
                return buildBody(state);
              } else {
                return const ShaderContainer(height: 220);
              }
            },
          )
        ],
      ),
    );
  }

  SizedBox buildBody(BusinessLoaded state) {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = state.posts[index];
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
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      "https://cp.dev.platina.uz${item.imageMedium}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 187,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 16,
        ),
        itemCount: state.posts.length,
      ),
    );
  }
}
