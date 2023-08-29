import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/posts.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'main_post_event.dart';
part 'main_post_state.dart';

class MainPostBloc extends Bloc<MainPostEvent, MainPostState> {
  MainPostBloc() : super(MainPostInitial()) {
    List<Posts> posts = [];
    Repository _repository = Repository();
    int page = 1;

    on<GetMainPosts>((event, emit) async {
      try {
        final postsModel = await _repository.getPosts(page);
        posts.add(postsModel);
        emit(MainPostLoaded(posts.first));
      } catch (e) {
        emit(MainPostError(e.toString()));
      }
    });

    on<GetMorePosts>((event, emit) async {
      try {
        page++;
        final postsModel = await Repository().getPosts(page);
        posts.first.next = postsModel.next;
        posts.first.previous = postsModel.previous;
        for (var i = 0; i < postsModel.results.length; i++) {
          posts.first.results.add(postsModel.results[i]);
        }

        emit(MainPostLoaded(posts.first));
      } catch (e) {
        emit(MainPostError(e.toString()));
      }
    });
  }
}
