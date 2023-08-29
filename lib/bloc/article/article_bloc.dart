import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/articles.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  List<Articles> articles = [];

  ArticleBloc() : super(ArticleInitial()) {
    int page = 1;
    on<GetArticlesEvent>((event, emit) async {
      try {
        final articlesModel = await Repository().getArticles(page);
        articles.add(articlesModel);
        emit(ArticleLoaded(articles.first));
      } catch (e) {
        emit(
          ArticleError(
            e.toString(),
          ),
        );
      }
    });
    on<GetMoreArticlesEvent>((event, emit) async {
      try {
        page++;

        final articlesModel = await Repository().getArticles(page);
        articles.first.next = articlesModel.next;
        articles.first.previous = articlesModel.previous;
        for (var i = 0; i < articlesModel.results.length; i++) {
          articles.first.results.add(articlesModel.results[i]);
        }

        emit(ArticleLoaded(articles.first));
      } catch (e) {
        emit(ArticleError(e.toString()));
      }
    });
  }
}
