import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/video.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    int page = 1;
    List<Video> videos = [];
    on<GetVideoEvent>((event, emit) async {
      try {
        final video = await Repository().getVideo(page);
        videos.add(video);
        emit(VideoLoaded(videos.first));
      } catch (e) {
        emit(VideoError(e.toString()));
      }
    });
    on<GetMoreVideoEvent>((event, emit) async {
      try {
        page++;
        final video = await Repository().getVideo(page);
        videos.first.next = video.next;
        videos.first.previous = video.previous;
        for (var i = 0; i < video.results.length; i++) {
          videos.first.results.add(video.results[i]);
        }
        emit(VideoLoaded(videos.first));
      } catch (e) {
        print(e);
        emit(VideoError(e.toString()));
      }
    });
  }
}
