part of 'landing_bloc.dart';

class LandingState {
  final int currentPageIndex;
  LandingState({this.currentPageIndex = 0});

  LandingState copyWith({int? currentPageIndex}) {
    return LandingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}
