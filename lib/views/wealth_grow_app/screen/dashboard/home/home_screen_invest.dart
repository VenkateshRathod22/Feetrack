import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/home_screen_invest_appbar.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class HomeScreenInvest extends StatelessWidget {
  const HomeScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomeScreenInvestAppbar(),
        body: SingleChildScrollView(
          padding: AppConstants.screenPadding,
        ),
      ),
    );
  }
}
