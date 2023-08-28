part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class GetSearchResults extends SearchEvent {
  final String query;
  GetSearchResults(this.query);
}
