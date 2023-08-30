import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/svg/logo.svg"),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Text(
                "aboutSite".tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: kprimaryColor),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "ad".tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: kprimaryColor),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "privacyPolicy".tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: kprimaryColor),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "footer1".tr(),
            style: TextStyle(
              fontSize: 12,
              color: kGreyTextColor,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "footer2".tr(),
            style: TextStyle(
              fontSize: 12,
              color: kGreyTextColor,
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse("https://t.me/platinauzb"),
                          mode: LaunchMode.externalApplication)) {
                        throw Exception('Could not launch');
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/svg/telegram.svg"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(
                          Uri.parse("https://www.instagram.com/platinauzb/"),
                          mode: LaunchMode.externalApplication)) {
                        throw Exception('Could not launch');
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/svg/instagram.svg"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(
                          Uri.parse("https://facebook.com/platinauz"),
                          mode: LaunchMode.externalApplication)) {
                        throw Exception('Could not launch');
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/svg/facebook.svg"),
                    ),
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
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/svg/youtube.svg"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(
                          Uri.parse("https://twitter.com/platinauz"),
                          mode: LaunchMode.externalApplication)) {
                        throw Exception('Could not launch');
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/svg/twitter.svg"),
                    ),
                  ),
                ],
              ),
              Container(
                height: 35,
                width: 35,
                alignment: Alignment.center,
                child: Text(
                  "18+",
                  style: TextStyle(
                    color: kGreyTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SvgPicture.asset("assets/svg/redmedia.svg"),
              const SizedBox(
                width: 10,
              ),
              Text(
                "redMedia".tr(),
                style: TextStyle(
                  color: kGreyTextColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
