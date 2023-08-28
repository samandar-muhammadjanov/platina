part of 'main_post_bloc.dart';

@immutable
sealed class MainPostEvent {}

class GetMainPosts extends MainPostEvent {
  final String page;
  GetMainPosts(this.page);
}

class GetMorePosts extends MainPostEvent {
  final List<Posts> posts;
  GetMorePosts(this.posts);
}
