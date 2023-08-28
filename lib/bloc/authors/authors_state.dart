part of 'authors_bloc.dart';

@immutable
sealed class AuthorsState {}

final class AuthorsInitial extends AuthorsState {}

final class AuthorsLoading extends AuthorsState {}

final class AuthorsLoaded extends AuthorsState {
  final AuthorsOffered posts;
  AuthorsLoaded(this.posts);
}

final class AuthorsError extends AuthorsState {
  final String error;
  AuthorsError(this.error);
}
