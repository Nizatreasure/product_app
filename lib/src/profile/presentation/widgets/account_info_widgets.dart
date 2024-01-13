part of '../pages/account_info_page.dart';

Widget _buildNameField(BuildContext context) {
  return BlocBuilder<AccountInfoBloc, AccountInfoState>(
    builder: (_, state) {
      return CustomTextInputField(
        hintText: StringManager.fullName,
        fieldName: StringManager.name,
        textEditingController: context.read<AccountInfoBloc>().nameController,
        onChanged: (val) {
          context.read<AccountInfoBloc>().add(AccountInfoNameChangedEvent(val));
        },
      );
    },
  );
}

Widget _buildEmailField(BuildContext context) {
  return BlocBuilder<AccountInfoBloc, AccountInfoState>(
    builder: (_, state) {
      return CustomTextInputField(
        fieldName: StringManager.emailAddress,
        hintText: StringManager.enterEmailAddress,
        textEditingController: context.read<AccountInfoBloc>().emailController,
        textCapitalization: TextCapitalization.none,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        keyboardType: TextInputType.emailAddress,
        onChanged: (val) {
          context
              .read<AccountInfoBloc>()
              .add(AccountInfoEmailChangedEvent(val));
        },
      );
    },
  );
}

_showOptions(BuildContext context, ThemeData themeData) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: themeData.dialogBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(50.r),
        topEnd: Radius.circular(50.r),
      ),
    ),
    builder: (childContext) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(40.w, 10.h, 10.h, 35.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 22.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringManager.uploadImage,
                  style: themeData.textTheme.bodyLarge!
                      .copyWith(fontSize: FontSizeManager.f24),
                ),
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            _buildOptions(
              context: childContext,
              themeData: themeData,
              text: StringManager.takeAPicture,
              asset: AppAssetManager.camera,
              onTap: () {
                childContext.pop();
                if (Globals.cameras.isEmpty) {
                  showCustomDialog(
                    context,
                    title: StringManager.error,
                    body: StringManager.cameraNotFound,
                    confirmButtonText: StringManager.close,
                  );
                  return;
                }
                context.pushNamed(RouteNames.takePhoto,
                    extra: context.read<AccountInfoBloc>());
              },
            ),
            _buildOptions(
              context: childContext,
              themeData: themeData,
              text: StringManager.uploadFromGallery,
              asset: AppAssetManager.upload,
              onTap: () async {
                childContext.pop();
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result == null) return;
                context.read<AccountInfoBloc>().add(
                    AccountInfoImagePathChangedEvent(result.files.first.path!));
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildOptions({
  required BuildContext context,
  required ThemeData themeData,
  required String text,
  required String asset,
  required void Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 44.h,
      color: ColorManager.transparent,
      child: Row(
        children: [
          Container(
            width: 18.r,
            margin: EdgeInsetsDirectional.symmetric(horizontal: 5.r),
            color: Colors.transparent,
            child: SvgPicture.asset(
              asset,
              matchTextDirection: true,
              height: 18.r,
              colorFilter: ColorFilter.mode(
                  themeData.textTheme.bodyMedium!.color!.withOpacity(0.9),
                  BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: themeData.textTheme.bodyMedium,
          ),
        ],
      ),
    ),
  );
}

Widget _buildImage(BuildContext context, ThemeData themeData,
    AccountInfoState state, User? user) {
  return GestureDetector(
    onTap: () {
      _showOptions(context, themeData);
    },
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Container(
            // radius: 50.r,
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeData.dialogBackgroundColor,
            ),
            clipBehavior: Clip.antiAlias,
            child: state.profileImagePath.isEmpty
                ? user?.photoURL == null
                    ? Icon(
                        Icons.person_3,
                        size: 60,
                        color: themeData.canvasColor,
                      )
                    : CachedNetworkImage(
                        imageUrl: user!.photoURL!,
                        fit: BoxFit.cover,
                      )
                : Image.file(
                    File(state.profileImagePath),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        PositionedDirectional(
          end: 10.w,
          bottom: -2.h,
          child: SvgPicture.asset(
            AppAssetManager.edit,
            width: 24.r,
            height: 24.r,
          ),
        )
      ],
    ),
  );
}
