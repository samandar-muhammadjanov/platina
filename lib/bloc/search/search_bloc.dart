import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/search_results.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<GetSearchResults>((event, emit) async {
      try {
        emit(SearchLoading());
        final searchResult = await Repository().search(event.query);
        emit(SearchLoaded(searchResult));
      } catch (e) {
        emit(
          SearchError(
            e.toString(),
          ),
        );
      }
    });
  }
}
