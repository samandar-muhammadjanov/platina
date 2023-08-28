import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/articles.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleInitial()) {
    on<GetArticlesEvent>((event, emit) async {
      try {
        emit(ArticleLoading());
        final articles = await Repository().getArticles();
        emit(ArticleLoaded(articles));
      } catch (e) {
        emit(
          ArticleError(
            e.toString(),
          ),
        );
      }
    });
  }
}
