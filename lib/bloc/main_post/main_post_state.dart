part of 'main_post_bloc.dart';

@immutable
sealed class MainPostState {}

final class MainPostInitial extends MainPostState {}

final class MainPostLoading extends MainPostState {}

final class MainPostLoaded extends MainPostState {
  final Posts posts;
  MainPostLoaded(this.posts);
}

final class LoadmorePosts extends MainPostState {
  final List<Posts> posts;
  LoadmorePosts(this.posts);
}

final class MainPostError extends MainPostState {
  final String error;
  MainPostError(this.error);
}
