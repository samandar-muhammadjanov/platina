part of 'video_bloc.dart';

@immutable
sealed class VideoEvent {}

class GetVideoEvent extends VideoEvent {}

class GetMoreVideoEvent extends VideoEvent {}
