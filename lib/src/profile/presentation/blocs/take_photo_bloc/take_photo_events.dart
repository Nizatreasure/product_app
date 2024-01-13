part of 'take_photo_bloc.dart';

abstract class TakePhotoEvent {
  const TakePhotoEvent();
}

class TakePhotoInitialEvent extends TakePhotoEvent {
  final CameraDescription selectedCamera;
  TakePhotoInitialEvent(this.selectedCamera);
}

class TakePhotoChangeCameraEvent extends TakePhotoEvent {}

class TakePhotoStateValuesChangedEvent extends TakePhotoEvent {
  final bool? showFocusCircle;
  final bool? showFontScale;
  final double? x;
  final double? y;
  final double? fontScale;
  TakePhotoStateValuesChangedEvent({
    this.showFocusCircle,
    this.x,
    this.y,
    this.showFontScale,
    this.fontScale,
  });
}

class TakePhotChangeFlashModeEvent extends TakePhotoEvent {}

class TakePhotoSnapEvent extends TakePhotoEvent {}
