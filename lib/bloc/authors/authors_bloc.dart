import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/authors_offered.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'authors_event.dart';
part 'authors_state.dart';

class AuthorsBloc extends Bloc<AuthorsEvent, AuthorsState> {
  AuthorsBloc() : super(AuthorsInitial()) {
    on<GetAuthorsPosts>((event, emit) async {
      try {
        emit(AuthorsLoading());
        final posts = await Repository().getAuthorsOfferedPosts();
        emit(AuthorsLoaded(posts));
      } catch (e) {
        emit(AuthorsError(e.toString()));
      }
    });
  }
}
