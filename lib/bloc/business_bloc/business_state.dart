part of 'business_bloc.dart';

@immutable
sealed class BusinessState {}

final class BusinessInitial extends BusinessState {}

final class BusinessLoading extends BusinessState {}

final class BusinessLoaded extends BusinessState {
  final List<BusinessPosts> posts;
  BusinessLoaded(this.posts);
}

final class BusinessError extends BusinessState {
  final String error;
  BusinessError(this.error);
}
