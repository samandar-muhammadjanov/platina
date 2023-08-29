import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/popular_post.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    int page = 1;
    List<PopularPosts> posts = [];
    Repository _repository = Repository();
    on<GetPopularPosts>((event, emit) async {
      try {
        final postsModel = await _repository.getPopularPosts(page);
        posts.add(postsModel);
        emit(PopularPostsLoaded(posts.first));
      } catch (e) {
        emit(PostsError(e.toString()));
      }
    });
    on<GetMorePopularPosts>((event, emit) async {
      try {
        page++;
        final postsModel = await _repository.getPopularPosts(page);
        posts.first.next = postsModel.next;
        posts.first.previous = postsModel.previous;
        for (var i = 0; i < postsModel.results.length; i++) {
          posts.first.results.add(postsModel.results[i]);
        }
        emit(PopularPostsLoaded(posts.first));
      } catch (e) {
        emit(PostsError(e.toString()));
      }
    });
  }
}
