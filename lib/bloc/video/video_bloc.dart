import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/video.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<GetVideoEvent>((event, emit) async {
      try {
        emit(VideoLoading());
        final video = await Repository().getVideo();
        emit(VideoLoaded(video));
      } catch (e) {
        emit(VideoError(e.toString()));
      }
    });
  }
}
