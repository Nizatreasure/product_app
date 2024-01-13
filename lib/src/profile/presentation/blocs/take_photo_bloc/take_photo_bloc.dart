import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:product_app/core/common/enums/enums.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/core/constants/constants.dart';
import 'package:product_app/globals.dart';

part 'take_photo_events.dart';
part 'take_photo_state.dart';

class TakePhotoBloc extends Bloc<TakePhotoEvent, TakePhotoState> {
  TakePhotoBloc() : super(TakePhotoState(activeCamera: Globals.cameras.first)) {
    on<TakePhotoInitialEvent>(_initializeCamera);
    on<TakePhotoChangeCameraEvent>(_flipCamera);
    on<TakePhotChangeFlashModeEvent>(_changeFlashMode);
    on<TakePhotoSnapEvent>(_takePicture);
    on<TakePhotoStateValuesChangedEvent>(_stateValuesChanged);
  }

  _initializeCamera(
      TakePhotoInitialEvent event, Emitter<TakePhotoState> emit) async {
    emit(state.copyWith(activeCamera: event.selectedCamera));
    CameraController cameraController = CameraController(
        state.activeCamera, ResolutionPreset.high,
        imageFormatGroup: Platform.isIOS
            ? ImageFormatGroup.bgra8888
            : ImageFormatGroup.yuv420);

    emit(state.copyWith(cameraController: cameraController));

    try {
      await state.cameraController!.initialize();
      double maxZoom = await state.cameraController!.getMaxZoomLevel();
      double minZoom = await state.cameraController!.getMinZoomLevel();
      state.cameraController!.setFlashMode(FlashMode.auto);
      state.cameraController!.setExposureMode(ExposureMode.auto);
      emit(
        state.copyWith(
          maxZoom: maxZoom,
          minZoom: minZoom,
        ),
      );
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          emit(state.copyWith(error: CameraError.permission));
          break;

        default:
          emit(state.copyWith(error: CameraError.other));
          break;
      }
    } catch (e) {
      emit(state.copyWith(error: CameraError.other));
    }
  }

  _flipCamera(
      TakePhotoChangeCameraEvent event, Emitter<TakePhotoState> emit) async {
    if (Globals.cameras.length < 2) return;
    CameraDescription c = state.activeCamera == Globals.cameras.first
        ? Globals.cameras[1]
        : Globals.cameras[0];
    emit(state.copyWith(turns: state.turns == 0 ? 0.5 : 0));
    await state.cameraController!.setZoomLevel(1);
    if (c != Globals.cameras[1]) {
      await state.cameraController!.setFocusMode(FocusMode.auto);
      if (Platform.isAndroid) {
        await state.cameraController!.setFocusPoint(null);
      }
    }
    add(TakePhotoInitialEvent(c));
  }

  _changeFlashMode(
      TakePhotChangeFlashModeEvent event, Emitter<TakePhotoState> emit) async {
    int flashModeIndex = AppConstants.flashMode.indexWhere((element) =>
        element.name == state.cameraController!.value.flashMode.name);
    FlashMode selectedFlashMode =
        AppConstants.flashMode[(flashModeIndex + 1) % 4];
    state.cameraController!.setFlashMode(selectedFlashMode);
    await Future.delayed(const Duration(milliseconds: 1));
    emit(state.copyWith(selectedFlashMode: selectedFlashMode));
  }

  _takePicture(TakePhotoSnapEvent event, Emitter<TakePhotoState> emit) async {
    try {
      emit(state.copyWith(cameraStatus: SubmittingForm()));
      final image = await state.cameraController!.takePicture();

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            hideBottomControls: true,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            backgroundColor: Colors.black,
            statusBarColor: Colors.black,
            toolbarColor: Colors.black,
            toolbarTitle: '',
            toolbarWidgetColor: Colors.white,
          ),
          IOSUiSettings(
            title: '',
            hidesNavigationBar: true,
            resetButtonHidden: true,
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
            rotateButtonsHidden: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );

      if (croppedFile != null) {
        emit(state.copyWith(
            cameraStatus: SubmissionSuccess<String>(croppedFile.path)));
      }
    } catch (_) {
    } finally {
      emit(state.copyWith(cameraStatus: const InitialFormStatus()));
    }
  }

  _stateValuesChanged(
      TakePhotoStateValuesChangedEvent event, Emitter<TakePhotoState> emit) {
    emit(state.copyWith(
      showFocusCircle: event.showFocusCircle,
      x: event.x,
      y: event.y,
      showFontScale: event.showFontScale,
      fontScale: event.fontScale,
    ));
  }

  @override
  Future<void> close() {
    state.cameraController?.dispose();
    return super.close();
  }
}
