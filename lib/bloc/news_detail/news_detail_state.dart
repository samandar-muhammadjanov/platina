part of 'news_detail_bloc.dart';

@immutable
sealed class NewsDetailState {}

final class NewsDetailInitial extends NewsDetailState {}

final class NewsDetailLoading extends NewsDetailState {}

final class NewsDetailLoaded extends NewsDetailState {
  final NewsDetail post;
  NewsDetailLoaded(this.post);
}

final class NewsDetailError extends NewsDetailState {
  final String error;
  NewsDetailError(this.error);
}
