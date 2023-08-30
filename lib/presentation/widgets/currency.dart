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
  bool _tile1Expanded = false;
  bool _tile2Expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _tile1Expanded = !_tile1Expanded;
                      _tile2Expanded = false;
                    });
                  },
                  child: BlocBuilder<CurrencyBloc, CurrencyState>(
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
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child:
                                item("assets/svg/USD.svg", "USD", "00000", "0"),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    _tile2Expanded = !_tile2Expanded;
                    _tile1Expanded = false;
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
                          mainAxisAlignment: MainAxisAlignment.end,
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
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/svg/sun.svg"),
                              const Text(
                                "+0 °C",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ))
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _tile1Expanded ? 20 : 0,
          width: double.infinity, // Change color as needed
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: _tile2Expanded ? 138 : 0,
          width: double.infinity,
          color: white, // Change color as needed
          child: Padding(
            padding: EdgeInsets.all(_tile2Expanded ? 16.0 : 0),
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
