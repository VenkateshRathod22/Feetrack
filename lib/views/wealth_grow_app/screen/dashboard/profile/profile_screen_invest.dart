import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/profile/widget/profile_option_section_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/profile/widget/profile_top_section.dart';

class ProfileScreenInvest extends StatelessWidget {
  const ProfileScreenInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(
          "Profile",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 24.sp,
              ),
        ),
      ),
      body: Column(
        children: [
          const ProfileTopSectionInvest(),
          Expanded(
            child: const ProfileOptionSectionInvest(),
          ),
        ],
      ),
    );
  }
}
