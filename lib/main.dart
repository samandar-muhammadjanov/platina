import 'package:flutter/material.dart';
import 'package:platina/app/my_app.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'package:path_provider/path_provider.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale("uz", "UZ"),
        Locale.fromSubtags(
            languageCode: "uz", scriptCode: "Cyrl", countryCode: "UZ"),
      ],
      path: "assets/translation",
      saveLocale: true,
      fallbackLocale: const Locale.fromSubtags(
          languageCode: "uz", scriptCode: "Cyrl", countryCode: "UZ"),
      child: const MyApp()));
}
