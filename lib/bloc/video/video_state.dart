part of 'video_bloc.dart';

@immutable
sealed class VideoState {}

final class VideoInitial extends VideoState {}

final class VideoLoading extends VideoState {}

final class VideoLoaded extends VideoState {
  final Video video;
  VideoLoaded(this.video);
}

final class VideoError extends VideoState {
  final String error;
  VideoError(this.error);
}
