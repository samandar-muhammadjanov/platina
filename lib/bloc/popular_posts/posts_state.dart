part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PopularPostsLoaded extends PostsState {
  final PopularPosts posts;
  PopularPostsLoaded(this.posts);
}

final class PostsError extends PostsState {
  final String error;
  PostsError(this.error);
}
