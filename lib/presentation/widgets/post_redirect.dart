import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/bloc/bloc_import.dart';
import '/domain/repositories/respository.dart';
import '/presentation/widgets/next_and_prev_post.dart';
import '/presentation/widgets/subject_posts.dart';
import '/utils/colors.dart';
import '/utils/extantions.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:share_plus/share_plus.dart';

class PostRedirect extends StatefulWidget {
  const PostRedirect({
    super.key,
    required this.year,
    required this.month,
    required this.day,
    required this.slug,
  });
  final String year;
  final String month;
  final String day;
  final String slug;

  @override
  State<PostRedirect> createState() => _PostRedirectState();
}

class _PostRedirectState extends State<PostRedirect> {
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Repository()
        .getNewsDetail(widget.year, widget.month, widget.day, widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsDetailBloc()
        ..add(
            GetNewsDetail(widget.year, widget.month, widget.day, widget.slug)),
      child: BlocBuilder<NewsDetailBloc, NewsDetailState>(
        builder: (context, state) {
          if (state is NewsDetailError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is NewsDetailLoaded) {
            final item = state.post.postDetail;
            final nextPost = state.post.nextPost;
            final prevPost = state.post.prevPost;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: kprimaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        item.shortDescription
                            .removeHtmlTags()
                            .replaceSpecialSymbols(),
                        maxLines: 2,
                        style: TextStyle(
                          color: kGreyTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                item.category.name,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: item.category.color
                                        .toColor()
                                        .withOpacity(1)),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Text(
                                item.publish.timePassedFromNow(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: kLightGreyTextColor),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Share.share(
                                  "https://platina.uz/${widget.year}/${widget.month}/${widget.day}/${widget.slug}",
                                  subject: item.title);
                            },
                            icon: SvgPicture.asset("assets/svg/Share.svg"),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      item.youtubeLink.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: YoutubePlayer(
                                controller: YoutubePlayerController.fromVideoId(
                                    videoId: item.youtubeLink
                                        .toString()
                                        .split("/")
                                        .last),
                              ),
                            )
                          : item.gallery.isNotEmpty
                              ? SizedBox(
                                  height: 218,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      PageView.builder(
                                        onPageChanged: (value) {
                                          setState(() {
                                            currentIndex = value;
                                          });
                                        },
                                        itemCount: item.gallery.length,
                                        itemBuilder: (context, index) {
                                          final images = item.gallery[index];
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.network(
                                              "https://cp.dev.platina.uz${images["image"]}",
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 50,
                                        right: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              item.gallery.length, (index) {
                                            return AnimatedContainer(
                                              margin: const EdgeInsets.only(
                                                  right: 5.33),
                                              height: currentIndex == index
                                                  ? 8
                                                  : 5.33,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color(0xffD5DDF3)
                                                    .withOpacity(
                                                        currentIndex == index
                                                            ? 1
                                                            : 0.7),
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 400),
                                            );
                                          }),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    "https://cp.dev.platina.uz/${item.imageMedium}",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                      const SizedBox(
                        height: 15,
                      ),
                      Html(
                        data: item.description,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(item.tags.length, (index) {
                              final tag = item.tags[index];
                              return Container(
                                margin: const EdgeInsets.only(right: 14),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                decoration: BoxDecoration(
                                    color: kbackground,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/svg/hashtag.svg"),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      tag,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: kprimaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Share.share(
                                        "https://platina.uz/${widget.year}/${widget.month}/${widget.day}/${widget.slug}",
                                        subject: item.title);
                                  },
                                  icon:
                                      SvgPicture.asset("assets/svg/Share.svg"))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                NextAndPrevPosts(nextPost: nextPost, prevPost: prevPost),
                Subject(state: state),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
