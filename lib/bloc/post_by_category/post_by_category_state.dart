part of 'post_by_category_bloc.dart';

@immutable
sealed class PostByCategoryState {}

final class PostByCategoryInitial extends PostByCategoryState {}

final class PostByCategoryLoading extends PostByCategoryState {}

final class PostByCategoryLoaded extends PostByCategoryState {
  final PostsByCategory post;
  PostByCategoryLoaded(this.post);
}

final class PostByCategoryError extends PostByCategoryState {
  final String error;
  PostByCategoryError(this.error);
}
