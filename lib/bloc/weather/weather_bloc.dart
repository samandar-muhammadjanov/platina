import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/weather.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      try {
        final weather = await Repository().getWeather();
        emit(WeatherLoaded(weather));
      } catch (e) {}
    });
  }
}
