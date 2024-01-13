import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/common/enums/enums.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/core/constants/constants.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/color_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/src/profile/presentation/blocs/account_info_bloc/account_info_bloc.dart';

import '../blocs/take_photo_bloc/take_photo_bloc.dart';

part '../widgets/take_photo_widgets.dart';

class TakePhoto extends StatefulWidget {
  final AccountInfoBloc bloc;
  const TakePhoto(this.bloc, {Key? key}) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> with WidgetsBindingObserver {
  double _baseFontScale = 1;
  late TakePhotoBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TakePhotoBloc>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (bloc.state.cameraController != null &&
          bloc.state.cameraController!.value.isInitialized) {
        bloc.state.cameraController!.pausePreview();
      }
    }
    if (state == AppLifecycleState.resumed) {
      if (bloc.state.cameraController != null &&
          bloc.state.cameraController!.value.isInitialized) {
        bloc.state.cameraController!.resumePreview();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: BlocListener<TakePhotoBloc, TakePhotoState>(
        listener: (context, state) {
          if (state.error == CameraError.permission) {
            _accessDenied();
          }
          if (state.error == CameraError.other) {
            _defaultError(context, themeData);
          }

          if (state.cameraStatus is SubmissionSuccess) {
            _handleSuccess(state);
          }
        },
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              bottom: MediaQuery.of(context).viewPadding.bottom),
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<TakePhotoBloc, TakePhotoState>(
      builder: (context, state) {
        return state.cameraController != null &&
                state.cameraController!.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Transform.scale(
                      scale: 1.25,
                      child: _buildCameraPreview(state, context),
                    ),
                  ),
                  if (state.showFocusCircle) _buildFocusWidget(state),
                  _buildBottomButtons(state, context),
                  if (state.cameraStatus is SubmittingForm)
                    SizedBox(
                      width: 38.r,
                      height: 38.r,
                      child: const CircularProgressIndicator(
                        color: ColorManager.orange,
                      ),
                    ),
                ],
              )
            : const SizedBox();
      },
    );
  }

  Widget _buildCameraPreview(TakePhotoState state, BuildContext context) {
    return CameraPreview(
      state.cameraController!,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTapUp: (details) async {
                _onTapUp(details, state, context.read<TakePhotoBloc>());
              },
              onScaleStart: (details) {
                if (state.activeCamera.lensDirection ==
                    CameraLensDirection.front) {
                  return;
                }
                _baseFontScale = state.fontScale;
              },
              onScaleUpdate: (details) {
                _onscaleUpdate(details, state, context);
              },
              onScaleEnd: (details) async {
                _onScaleEnd(state, context);
              },
              child: _buildFontScale(state, context),
            ),
          )
        ],
      ),
    );
  }

  _accessDenied() {
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(
          StringManager.couldNotLaunchCamera,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  _onTapUp(
      TapUpDetails details, TakePhotoState state, TakePhotoBloc bloc) async {
    if (Platform.isIOS &&
        state.activeCamera.lensDirection == CameraLensDirection.front) return;

    double x = details.localPosition.dx;
    double y = details.localPosition.dy;

    double width = MediaQuery.of(context).size.width;

    double cameraHeight = width * state.cameraController!.value.aspectRatio;

    double tapPointX = x / width;
    double tapPointY =
        y / (cameraHeight + 50 + MediaQuery.of(context).viewPadding.top);

    if (tapPointX < 0 || tapPointY < 0 || tapPointY > 1 || tapPointX > 1) {
      return;
    }
    await Future.delayed(const Duration(milliseconds: 1));
    bloc.add(
        TakePhotoStateValuesChangedEvent(x: x, y: y, showFocusCircle: true));

    Offset tapPoint = Offset(tapPointX, tapPointY);

    EasyDebounce.debounce('hide-circle', const Duration(milliseconds: 500),
        () async {
      await state.cameraController!.setFocusMode(FocusMode.locked);
      await state.cameraController!.setFocusPoint(tapPoint);
      await state.cameraController!.setExposurePoint(tapPoint);
      await Future.delayed(const Duration(milliseconds: 1500));
      bloc.add(
          TakePhotoStateValuesChangedEvent(x: x, y: y, showFocusCircle: false));
    });
  }

  _onScaleEnd(TakePhotoState state, BuildContext context) async {
    if (state.activeCamera.lensDirection == CameraLensDirection.front) {
      return;
    }
    TakePhotoBloc bloc = context.read<TakePhotoBloc>();
    await Future.delayed(const Duration(milliseconds: 700));
    bloc.add(TakePhotoStateValuesChangedEvent(
      showFontScale: false,
    ));
  }

  _onscaleUpdate(
      ScaleUpdateDetails details, TakePhotoState state, BuildContext context) {
    if (state.activeCamera.lensDirection == CameraLensDirection.front) {
      return;
    }
    if (details.scale == 1) return;

    double fontScale = double.parse((_baseFontScale * details.scale)
        .clamp(state.minZoom, state.maxZoom)
        .toStringAsFixed(1));

    state.cameraController!.setZoomLevel(fontScale);

    context.read<TakePhotoBloc>().add(TakePhotoStateValuesChangedEvent(
        showFontScale: true, fontScale: fontScale));
  }

  _handleSuccess(TakePhotoState state) {
    widget.bloc.add(AccountInfoImagePathChangedEvent(
        (state.cameraStatus as SubmissionSuccess).data));
    context.pop();
  }
}
