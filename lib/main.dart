import 'package:flutter/material.dart';
import 'package:platina/bloc/bloc_import.dart';
import 'config/app_theme.dart';
import 'presentation/pages/dashboard.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostsBloc()..add(GetPopularPosts()),
        ),
        BlocProvider(
          create: (context) => AuthorsBloc()..add(GetAuthorsPosts()),
        ),
        BlocProvider(
          create: (context) => MainPostBloc()..add(GetMainPosts()),
        ),
        BlocProvider(
          create: (context) => BusinessBloc()..add(GetBussinessPosts()),
        ),
        BlocProvider(
          create: (context) => MenuBloc()..add(GetMenues()),
        ),
        BlocProvider(
          create: (context) => WeatherBloc()..add(GetWeather()),
        ),
        BlocProvider(
          create: (context) => PostByCategoryBloc()
            ..add(GetPostsByCategoryEvent("davlat-xaridlari")),
        ),
        BlocProvider(
          create: (context) => CurrencyBloc()..add(GetCurrencyEvent()),
        ),
        BlocProvider(
          create: (context) => ArticleBloc()..add(GetArticlesEvent()),
        ),
        BlocProvider(
          create: (context) => VideoBloc()..add(GetVideoEvent()),
        ),
        BlocProvider(
          create: (context) => NewsDetailBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Platina',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const Dashboard(),
      ),
    );
  }
}
