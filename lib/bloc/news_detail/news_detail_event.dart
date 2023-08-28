part of 'news_detail_bloc.dart';

@immutable
sealed class NewsDetailEvent {}

class GetNewsDetail extends NewsDetailEvent {
  final String year;
  final String month;
  final String day;
  final String slug;
  GetNewsDetail(this.year, this.month, this.day, this.slug);
}
