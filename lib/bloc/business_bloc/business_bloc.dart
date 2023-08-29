import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platina/domain/models/business_posts.dart';
import 'package:platina/domain/repositories/respository.dart';

part 'business_event.dart';
part 'business_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  BusinessBloc() : super(BusinessInitial()) {
    on<GetBussinessPosts>((event, emit) async {
      try {
        final posts = await Repository().getBusinessPosts();
        emit(BusinessLoaded(posts));
      } catch (e) {
        emit(BusinessError(e.toString()));
      }
    });
  }
}
