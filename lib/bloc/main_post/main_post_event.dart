part of 'main_post_bloc.dart';

@immutable
sealed class MainPostEvent {}

class GetMainPosts extends MainPostEvent {}

class GetMorePosts extends MainPostEvent {}
