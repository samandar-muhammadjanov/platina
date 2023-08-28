part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final SearchResult searchResult;
  SearchLoaded(this.searchResult);
}

final class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}
