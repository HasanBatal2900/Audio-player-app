import 'package:flutter/material.dart';

import '../../../core/constants/tabs.dart';
import '../../../core/constants/textstyle.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required this.tabController,
  });

  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: TabBar(
        unselectedLabelStyle: kUnselectedTabBarTextStyle,
        splashBorderRadius: BorderRadius.circular(5.0),
        enableFeedback: false,
        indicatorColor: Colors.white,
        automaticIndicatorColorAdjustment: true,
        indicatorWeight: 1,
        indicatorSize: TabBarIndicatorSize.tab,
        // labelStyle: kSelectedTabBarTextStyle,
        labelPadding: const EdgeInsets.only(bottom: 8),
        padding:
            const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
        tabs: tabs,
        controller: tabController,
      ),
    );
  }
}
