part of '../pages/landing_page.dart';

Widget _buildBottomNavigationBar(
    ThemeData themeData, List<LandingPageModel> pages, BuildContext context) {
  return BlocBuilder<LandingBloc, LandingState>(
    builder: (context, state) {
      return BottomNavigationBar(
        onTap: (value) {
          context.read<LandingBloc>().pageController.jumpToPage(value);
        },
        elevation: 0,
        currentIndex: state.currentPageIndex,
        items: List.generate(
          pages.length,
          (index) => _bottomItem(
            pages[index],
            index == state.currentPageIndex,
            themeData,
            index == 0,
          ),
        ),
      );
    },
  );
}

BottomNavigationBarItem _bottomItem(
    LandingPageModel item, bool isSelected, ThemeData themeData,
    [bool padding = false]) {
  bool isSvg = item.assetName.split('.').last == 'svg';
  return BottomNavigationBarItem(
    icon: Container(
      height: 24.r,
      width: 24.r,
      padding: EdgeInsetsDirectional.only(
        bottom: 2.h,
        start: padding ? 2 : 0,
        end: padding ? 2 : 0,
        top: padding ? 2 : 0,
      ),
      child: isSvg
          ? SvgPicture.asset(
              item.assetName,
              matchTextDirection: true,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? themeData.bottomNavigationBarTheme.selectedItemColor!
                    : themeData.bottomNavigationBarTheme.unselectedItemColor!,
                BlendMode.srcIn,
              ),
            )
          : Image.asset(
              item.assetName,
              matchTextDirection: true,
              color: isSelected
                  ? themeData.bottomNavigationBarTheme.selectedItemColor!
                  : themeData.bottomNavigationBarTheme.unselectedItemColor!,
              fit: BoxFit.contain,
            ),
    ),
    label: item.displayText,
  );
}
