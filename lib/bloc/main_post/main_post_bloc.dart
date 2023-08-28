import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/posts.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'main_post_event.dart';
part 'main_post_state.dart';

class MainPostBloc extends Bloc<MainPostEvent, MainPostState> {
  MainPostBloc() : super(MainPostInitial()) {
    Repository _repository = Repository();

    on<GetMainPosts>((event, emit) async {
      try {
        emit(MainPostLoading());
        final posts = await _repository.getPosts("1");
        emit(MainPostLoaded(posts));
      } catch (e) {
        emit(MainPostError(e.toString()));
      }
    });

    on<GetMorePosts>((event, emit) {
      try {
        emit(MainPostLoading());
        emit(LoadmorePosts(event.posts));
      } catch (e) {
        emit(
          MainPostError(
            e.toString(),
          ),
        );
      }
    });
  }
}
