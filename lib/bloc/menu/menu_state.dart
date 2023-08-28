part of 'menu_bloc.dart';

@immutable
sealed class MenuState {}

final class MenuInitial extends MenuState {}

final class MenuLoading extends MenuState {}

final class MenuLoaded extends MenuState {
  final List<Menues> categories;
  MenuLoaded(this.categories);
}

final class MenuError extends MenuState {
  final String error;
  MenuError(this.error);
}
