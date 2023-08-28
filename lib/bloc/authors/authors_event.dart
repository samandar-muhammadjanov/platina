part of 'authors_bloc.dart';

@immutable
sealed class AuthorsEvent {}

class GetAuthorsPosts extends AuthorsEvent {}
