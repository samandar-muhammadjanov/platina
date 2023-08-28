import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/menues.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<GetMenues>((event, emit) async {
      try {
        emit(MenuLoading());
        final categories = await Repository().getMenues();
        emit(MenuLoaded(categories));
      } catch (e) {
        emit(MenuError(e.toString()));
      }
    });
  }
}
