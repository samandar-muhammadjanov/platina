part of 'article_bloc.dart';

@immutable
sealed class ArticleEvent {}

class GetArticlesEvent extends ArticleEvent {}
