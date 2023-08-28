part of 'currency_bloc.dart';

@immutable
sealed class CurrencyState {}

final class CurrencyInitial extends CurrencyState {}

final class Currencyloading extends CurrencyState {}

final class CurrencyLoaded extends CurrencyState {
  final List<Currency> currency;
  CurrencyLoaded(this.currency);
}

final class CurrencyError extends CurrencyState {
  final String error;
  CurrencyError(this.error);
}
