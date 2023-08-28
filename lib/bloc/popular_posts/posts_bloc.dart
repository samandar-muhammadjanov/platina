import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/popular_post.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    Repository _repository = Repository();
    on<GetPopularPosts>((event, emit) async {
      try {
        emit(PostsLoading());
        final posts = await _repository.getPopularPosts();
        emit(PopularPostsLoaded(posts));
      } catch (e) {
        emit(PostsError(e.toString()));
      }
    });
  }
}
