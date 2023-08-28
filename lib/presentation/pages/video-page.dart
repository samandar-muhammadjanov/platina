import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/presentation/pages/news_detail.dart';
import 'package:platina/presentation/widgets/business.dart';
import 'package:platina/presentation/widgets/currency.dart';
import 'package:platina/presentation/widgets/footer.dart';
import 'package:platina/utils/colors.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Currency(),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<VideoBloc, VideoState>(
                builder: (context, state) {
                  if (state is VideoLoaded) {
                    return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "Видео",
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
                            const Divider(
                              height: 20,
                            ),
                            buildBody(state, context),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 41,
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: kbackground),
                              child: Text(
                                "Яна юклаш",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: kprimaryColor),
                              ),
                            )
                          ],
                        ));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const Business(),
              const SizedBox(height: 20),
              const Footer()
            ],
          ),
        ),
      ),
    );
  }

  Column buildBody(VideoLoaded state, BuildContext context) {
    return Column(
      children: List.generate(state.video.results.length * 2 - 1, (index) {
        final itemIndex = index ~/ 2;
        final item = state.video.results[itemIndex];
        if (index.isOdd) {
          return const Divider(
            height: 20,
          ); // Adds a divider for odd indices
        }
        return InkWell(
          onTap: () {
            print(DateFormat("M").format(item.publish));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailPage(
                  year: DateFormat("yyyy").format(item.publish),
                  month: DateFormat("M").format(item.publish),
                  day: DateFormat("ddd").format(item.publish),
                  slug: item.slug,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://cp.dev.platina.uz${item.imageMedium}",
                  height: 240,
                  fit: BoxFit.cover,
                  width: double.infinity,
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
            ],
          ),
        );
      }),
    );
  }
}
