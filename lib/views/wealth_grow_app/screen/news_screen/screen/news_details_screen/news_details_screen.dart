import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';

import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/news_screen/screen/news_screen/widget/news_card.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class NewsDetailsScreenInvest extends StatelessWidget {

  const NewsDetailsScreenInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        backgroundColor: backgroundDark,
        elevation: 0,
      
        title: CustomText(
          'News Details',
          style: Helper(context).textTheme.titleLarge?.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: GetBuilder<BasicControllerInvest>(
        builder: (basicControllerInvest) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                16.w,
                10.h,
                16.w,
                30.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==================================================
                  // IMAGE
                  // ==================================================
          
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.r),
                    child: NewsImage(
                      image: basicControllerInvest.selectNews?.imageFormat ,
                    ),
                  ),
          
                  sizedBoxHeight(height: 20),
          
                  
          
                  // ==================================================
                  // NEWS TITLE
                  // ==================================================
          
                  CustomText(
                    _getTitle(basicControllerInvest),
                    overflow: TextOverflow.clip,
                    style: Helper(context).textTheme.headlineSmall?.copyWith(
                          color: textPrimary,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                        ),
                  ),
          
                  sizedBoxHeight(height: 16),
          
                  // ==================================================
                  // DIVIDER
                  // ==================================================
          
                  const Divider(
                    color: borderDark,
                    height: 1,
                  ),
          
                  sizedBoxHeight(height: 18),
          
                  // ==================================================
                  // NEWS CONTENT
                  // ==================================================
          
                  CustomText(
                    basicControllerInvest.selectNews?.news?.trim().isNotEmpty == true
                        ? basicControllerInvest.selectNews?.news?.trim() ?? ""
                        : 'No news details available.',
                                            overflow: TextOverflow.clip,

                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          color: textSecondaryLight,
                          height: 1.7,
                        ),
                  ),
          
                  sizedBoxHeight(height: 24),
          
                  // ==================================================
                  // NEWS ID
                  // ==================================================
          
                  if (basicControllerInvest.selectNews?.id?.trim().isNotEmpty == true)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: surfaceNavy,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: borderDark,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.article_outlined,
                            color: textMuted,
                            size: 18.w,
                          ),
                          sizedBoxWidth(width: 8),
                          CustomText(
                            'News ID: ${basicControllerInvest.selectNews?.id}',
                            style: Helper(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: textMuted,
                                ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  String _getTitle(BasicControllerInvest basicControllerInvest) {
    final String value = basicControllerInvest.selectNews?.news?.trim() ?? '';

    if (value.isEmpty) {
      return 'News';
    }

    if (value.length <= 45) {
      return value;
    }

    return '${value.substring(0, 45)}...';
  }
}