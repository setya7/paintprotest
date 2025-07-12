import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintprotest/features/home/presentation/bloc/home_event.dart';
import 'package:paintprotest/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
