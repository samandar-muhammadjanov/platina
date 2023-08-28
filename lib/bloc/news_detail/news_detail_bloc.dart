import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/news_detail.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'news_detail_event.dart';
part 'news_detail_state.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  NewsDetailBloc() : super(NewsDetailInitial()) {
    on<GetNewsDetail>((event, emit) async {
      try {
        emit(NewsDetailLoading());
        final post = await Repository()
            .getNewsDetail(event.year, event.month, event.day, event.slug);
        emit(NewsDetailLoaded(post));
      } catch (e) {
        emit(NewsDetailError(e.toString()));
      }
    });
  }
}
