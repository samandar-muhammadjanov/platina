import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/currency.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyInitial()) {
    on<GetCurrencyEvent>((event, emit) async {
      try {
        final currency = await Repository().getCurrency();
        emit(CurrencyLoaded(currency));
      } catch (e) {
        emit(
          CurrencyError(
            e.toString(),
          ),
        );
      }
    });
  }
}
