part of '../pages/take_photo_page.dart';

_defaultError(BuildContext context, ThemeData themeData) {
  if (!context.mounted) return;
  context.pop();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: themeData.colorScheme.error,
      content: Text(
        StringManager.couldNotLaunchCamera,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  );
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    toolbarHeight: kToolbarHeight.r,
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      child: Icon(
        CupertinoIcons.clear,
        size: 24.r,
        color: Colors.white,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    actions: [
      BlocBuilder<TakePhotoBloc, TakePhotoState>(builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.cameraController != null &&
                state.cameraController!.value.isInitialized) {
              context.read<TakePhotoBloc>().add(TakePhotChangeFlashModeEvent());
            }
          },
          child: Container(
            padding: const EdgeInsetsDirectional.all(5),
            child: state.cameraController != null &&
                    state.cameraController!.value.isInitialized
                ? Icon(
                    state.selectedFlashMode == AppConstants.flashMode[0]
                        ? Icons.flash_auto
                        : state.selectedFlashMode == AppConstants.flashMode[1]
                            ? Icons.flash_on
                            : state.selectedFlashMode ==
                                    AppConstants.flashMode[2]
                                ? Icons.flash_off
                                : Icons.flash_on,
                    color: state.selectedFlashMode == AppConstants.flashMode[3]
                        ? Colors.yellow
                        : Colors.white,
                    size: 25.r,
                  )
                : Icon(
                    Icons.flash_auto,
                    color: Colors.white,
                    size: 25.r,
                  ),
          ),
        );
      }),
      SizedBox(width: 20.w),
    ],
  );
}

Widget _buildSwapCameraButton(TakePhotoState state, BuildContext context) {
  return GestureDetector(
    child: CircleAvatar(
      backgroundColor: Colors.grey.shade100.withOpacity(0.7),
      radius: 30.r.clamp(30, 50),
      child: AnimatedRotation(
        duration: const Duration(milliseconds: 400),
        turns: state.turns,
        child: SvgPicture.asset(
          AppAssetManager.sync,
          height: 30.r.clamp(30, 70),
        ),
      ),
    ),
    onTap: () {
      if (state.cameraController != null &&
          state.cameraController!.value.isInitialized) {
        context.read<TakePhotoBloc>().add(TakePhotoChangeCameraEvent());
      }
    },
  );
}

Widget _buildSnapButton(TakePhotoState state, BuildContext context) {
  return GestureDetector(
    child: Image.asset(
      AppAssetManager.voicePlay,
      height: 90.r.clamp(90, 150),
    ),
    onTap: () {
      if (state.cameraController != null &&
          state.cameraController!.value.isInitialized) {
        context.read<TakePhotoBloc>().add(TakePhotoSnapEvent());
      }
    },
  );
}

Widget _buildBottomButtons(TakePhotoState state, BuildContext context) {
  return Positioned(
    bottom: 40.h,
    left: 0,
    right: 0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30.r.clamp(30, 50),
        ),
        _buildSnapButton(state, context),
        _buildSwapCameraButton(state, context),
      ],
    ),
  );
}

Widget _buildFontScale(TakePhotoState state, BuildContext context) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Colors.transparent,
    alignment: Alignment.center,
    child: Text(
      state.showFontScale ? '${state.fontScale} X' : '',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 35.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
    ),
  );
}

Widget _buildFocusWidget(TakePhotoState state) {
  return Positioned(
    top: state.y - 30,
    left: state.x - 30,
    child: Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.5),
        shape: BoxShape.circle,
      ),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.5),
          shape: BoxShape.circle,
        ),
      ),
    ),
  );
}
