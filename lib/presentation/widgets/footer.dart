
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/utils/colors.dart';

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
                "Сайт ҳақида",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: kprimaryColor),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "Реклама",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: kprimaryColor),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "Маҳфийлик сиёсати",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: kprimaryColor),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "© 2023 Platina.uz. Барча ҳуқуқлар ҳимояланган. «Platina.uz» сайтида жойланган маълумотлар муаллифнинг шахсий фикри. Сайтда жойланган ҳар қандай материалларни ёзма рухсатсиз фойдаланиш таъқиқланади.",
            style: TextStyle(
              fontSize: 12,
              color: kGreyTextColor,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Ўзбекистон Республикаси Президенти Администрацияси ҳузуридаги Ахборот ва оммавий коммуникациялар агентлиги томонидан 02.12.2022 санасида №051412 сонли гувоҳнома билан ОАВ сифатида рўйхатга олинган",
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
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/telegram.svg"),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/instagram.svg"),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/facebook.svg"),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/youtube.svg"),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/twitter.svg"),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/tiktok.svg"),
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
                "IT-компанияси томонидан ишлаб чиқилди",
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
