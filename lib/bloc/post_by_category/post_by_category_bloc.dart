import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/posts_by_category.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'post_by_category_event.dart';
part 'post_by_category_state.dart';

class PostByCategoryBloc
    extends Bloc<PostByCategoryEvent, PostByCategoryState> {
  PostByCategoryBloc() : super(PostByCategoryInitial()) {
    on<GetPostsByCategoryEvent>((event, emit) async {
      try {
        final post = await Repository().getPostsByCategory(event.category);
        emit(PostByCategoryLoaded(post));
      } catch (e) {
        emit(PostByCategoryError(e.toString()));
      }
    });
  }
}
