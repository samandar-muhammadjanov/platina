part of 'article_bloc.dart';

@immutable
sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class ArticleLoading extends ArticleState {}

final class ArticleLoaded extends ArticleState {
  final Articles articles;
  ArticleLoaded(this.articles);
}

final class ArticleError extends ArticleState {
  final String error;
  ArticleError(this.error);
}
