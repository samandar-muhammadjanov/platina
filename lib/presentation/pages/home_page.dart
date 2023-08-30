import 'package:flutter/material.dart';
import 'package:platina/presentation/widgets/articles.dart';
import 'package:platina/presentation/widgets/business.dart';
import 'package:platina/presentation/widgets/currency.dart';
import 'package:platina/presentation/widgets/editors_choice.dart';
import 'package:platina/presentation/widgets/footer.dart';
import 'package:platina/presentation/widgets/important_news.dart';
import 'package:platina/presentation/widgets/state_purchases.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            Currency(),
            ImportantNews(),
            SizedBox(height: 20),
            EditorsChoice(),
            SizedBox(height: 20),
            Articles(),
            SizedBox(height: 20),
            StatePurchases(),
            SizedBox(height: 20),
            Business(),
            SizedBox(height: 20),
            Footer()
          ],
        ),
      ],
    );
  }
}
