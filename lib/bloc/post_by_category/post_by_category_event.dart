part of 'post_by_category_bloc.dart';

@immutable
sealed class PostByCategoryEvent {}

class GetPostsByCategoryEvent extends PostByCategoryEvent {
  final String category;
  GetPostsByCategoryEvent(this.category);
}
