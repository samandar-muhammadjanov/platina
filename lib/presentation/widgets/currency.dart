import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:platina/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class Currency extends StatefulWidget {
  const Currency({
    super.key,
  });

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  bool isWeatherVisible = true;
  bool isVisiable = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: () {
                setState(() {
                  isVisiable = !isVisiable;
                  isWeatherVisible = true;
                });
              }, child: BlocBuilder<CurrencyBloc, CurrencyState>(
                builder: (context, state) {
                  if (state is CurrencyLoaded) {
                    final currency = state.currency
                        .firstWhere((element) => element.ccy == "USD");
                    return item("assets/svg/USD.svg", currency.ccy,
                        currency.rate, currency.diff);
                  } else if (state is CurrencyError) {
                    return const SizedBox();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child:
                                item("assets/svg/USD.svg", "USD", "00000", "0"),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Row(
                              children: [
                                Image.network(
                                    "https://openweathermap.org/img/wn/01n.png"),
                                const Text(
                                  "+0 °C",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              )),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isWeatherVisible = !isWeatherVisible;
                  });
                },
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoaded) {
                      final item = state.weather.list[0];

                      final temp = item.main.temp > 0
                          ? "+${item.main.temp.toStringAsFixed(0)} °C"
                          : "-${item.main.temp.toStringAsFixed(0)} °C";
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Image.network(
                                "https://openweathermap.org/img/wn/${item.weather[0].icon}.png"),
                            Text(
                              temp,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: !isWeatherVisible,
          child: Container(
            height: 138,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
            ),
            child: ShaderMask(shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.center,
                end: Alignment.centerRight,
                colors: [
                  white,
                  white.withOpacity(.3),
                ],
              ).createShader(bounds);
            }, child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherError) {
                  return const SizedBox();
                } else if (state is WeatherLoaded) {
                  return buildWeather(state);
                } else {
                  return const SizedBox();
                }
              },
            )),
          ),
        ),
        Visibility(
          visible: isWeatherVisible && isVisiable,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyLoaded) {
                  final rub = state.currency
                      .firstWhere((element) => element.ccy == "RUB");
                  final euro = state.currency
                      .firstWhere((element) => element.ccy == "EUR");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      item(
                          "assets/svg/EUR.svg", euro.ccy, euro.rate, euro.diff),
                      item("assets/svg/RUB.svg", rub.ccy, rub.rate, rub.diff),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  ListView buildWeather(WeatherLoaded waetherList) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: waetherList.weather.list.length,
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final item = waetherList.weather.list[index];
        final maxTemp = item.main.tempMax > 0
            ? "+${item.main.tempMax.toStringAsFixed(0)}°"
            : "-${item.main.tempMax.toStringAsFixed(0)}°";
        final minTemp = item.main.tempMin > 0
            ? "+${item.main.tempMin.toStringAsFixed(0)}°"
            : "-${item.main.tempMin.toStringAsFixed(0)}°";
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("dd MMM").format(item.dtTxt),
              style: TextStyle(
                  color: kGreyTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              DateFormat("hh:mm").format(item.dtTxt),
              style: TextStyle(
                color: kprimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Image.network(
                "https://openweathermap.org/img/wn/${item.weather[0].icon}.png"),
            const SizedBox(
              height: 4,
            ),
            Text(
              "$minTemp $maxTemp",
              style: TextStyle(
                color: kprimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        );
      },
    );
  }

  Widget item(leading, title, currency, String diff) {
    final bool isGrowned = diff.split('')[0] == "-" ? true : false;
    return Row(
      children: [
        SvgPicture.asset(leading),
        const SizedBox(
          width: 8,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
                color: kprimaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: "sfpro"),
            children: [
              TextSpan(text: "$title "),
              TextSpan(
                text: currency,
                style: TextStyle(color: isGrowned ? kCurrencyRed : kActiveMenu),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Transform.rotate(
          angle: isGrowned ? 0 : 4.7,
          child: SvgPicture.asset(
            "assets/svg/downcurrency.svg",
            color: isGrowned ? kCurrencyRed : kActiveMenu,
          ),
        )
      ],
    );
  }
}
