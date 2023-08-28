part of 'currency_bloc.dart';

@immutable
sealed class CurrencyEvent {}

class GetCurrencyEvent extends CurrencyEvent {}
