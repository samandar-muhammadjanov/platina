import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_detail_event.dart';
part 'show_detail_state.dart';

class ShowDetailBloc extends Bloc<ShowDetailEvent, ShowDetailState> {
  ShowDetailBloc() : super(ShowDetailInitial()) {
    on<ShowDetail>((event, emit) {
      
    });
  }
}
