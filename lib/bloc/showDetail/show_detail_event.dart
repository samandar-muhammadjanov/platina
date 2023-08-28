part of 'show_detail_bloc.dart';

@immutable
sealed class ShowDetailEvent {}

class ShowDetail extends ShowDetailEvent {}

class UnshowDetail extends ShowDetailEvent {}
