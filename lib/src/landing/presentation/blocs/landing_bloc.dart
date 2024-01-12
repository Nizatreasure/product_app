import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  LandingBloc() : super(LandingState()) {
    on<LandingEvent>(_onPageChanged);
  }

  _onPageChanged(LandingEvent event, Emitter<LandingState> emit) {
    emit(state.copyWith(currentPageIndex: event.currentPageIndex));
  }
}
