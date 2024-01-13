import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_app/di.dart';
import 'package:product_app/src/landing/data/data_sources/landing_data_sources.dart';
import 'package:product_app/src/landing/data/models/landing_model.dart';

import '../blocs/landing_bloc.dart';

part '../widgets/landing_widgets.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeData themeData = Theme.of(context);
    return BlocProvider<LandingBloc>(
      create: (context) => getIt(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: _buildBody(context),
          bottomNavigationBar: _buildBottomNavigationBar(
              themeData, LandingLocalDataSource.pages, context),
        );
      }),
    );
  }

  PageView _buildBody(BuildContext context) {
    return PageView.builder(
      itemCount: LandingLocalDataSource.pages.length,
      allowImplicitScrolling: true,
      controller: context.read<LandingBloc>().pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (value) {
        context.read<LandingBloc>().add(LandingEvent(value));
      },
      itemBuilder: (_, index) {
        return LandingLocalDataSource.pages[index].widget;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
