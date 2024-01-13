part of 'take_photo_bloc.dart';

class TakePhotoState {
  final double turns;
  final double fontScale;
  final double maxZoom;
  final double minZoom;
  final bool showFontScale;
  final bool showFocusCircle;
  final double x;
  final double y;
  final FlashMode selectedFlashMode;
  final CameraError error;
  final CameraDescription activeCamera;
  final FormSubmissionStatus cameraStatus;
  final CameraController? cameraController;

  TakePhotoState({
    this.turns = 0,
    this.fontScale = 1,
    this.maxZoom = 1,
    this.minZoom = 0.1,
    this.showFocusCircle = false,
    this.showFontScale = false,
    this.x = 0,
    this.y = 0,
    this.selectedFlashMode = FlashMode.auto,
    this.error = CameraError.none,
    required this.activeCamera,
    this.cameraStatus = const InitialFormStatus(),
    this.cameraController,
  });

  TakePhotoState copyWith({
    double? turns,
    double? fontScale,
    double? maxZoom,
    double? minZoom,
    bool? showFontScale,
    bool? showFocusCircle,
    double? x,
    double? y,
    FlashMode? selectedFlashMode,
    CameraError? error,
    CameraDescription? activeCamera,
    FormSubmissionStatus? cameraStatus,
    CameraController? cameraController,
  }) {
    return TakePhotoState(
      fontScale: fontScale ?? this.fontScale,
      maxZoom: maxZoom ?? this.maxZoom,
      minZoom: minZoom ?? this.minZoom,
      selectedFlashMode: selectedFlashMode ?? this.selectedFlashMode,
      showFocusCircle: showFocusCircle ?? this.showFocusCircle,
      showFontScale: showFontScale ?? this.showFontScale,
      turns: turns ?? this.turns,
      x: x ?? this.x,
      y: y ?? this.y,
      error: error ?? this.error,
      activeCamera: activeCamera ?? this.activeCamera,
      cameraStatus: cameraStatus ?? this.cameraStatus,
      cameraController: cameraController ?? this.cameraController,
    );
  }
}
