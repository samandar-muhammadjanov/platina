part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class GetPopularPosts extends PostsEvent {}

class GetMorePopularPosts extends PostsEvent {}
