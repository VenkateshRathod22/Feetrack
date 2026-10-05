import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/data/models/invest_model/home_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/screen/news_screen/screen/news_screen/widget/news_card.dart';

import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class NewsScreenInvest extends StatelessWidget {
  const NewsScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        backgroundColor: backgroundDark,
        elevation: 0,
        title: CustomText(
          'News',
          style: Helper(context).textTheme.titleLarge?.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        
      ),
      body: GetBuilder<BasicControllerInvest>(
        builder: (controller) {
          final News? news = controller.homeInvestModel?.news;

          return _NewsList(
            news: news,
            basicControllerInvest : controller
          );
        },
      ),
    );
  }
}

// ============================================================
// NEWS LIST
// ============================================================

class _NewsList extends StatelessWidget {
  final News? news;
  final BasicControllerInvest basicControllerInvest;

  const _NewsList({
    required this.news, required this.basicControllerInvest,
  });

  @override
  Widget build(BuildContext context) {
    // --------------------------------------------------------
    // EMPTY STATE
    // --------------------------------------------------------

    if (news == null) {
      return const _EmptyNewsView();
    }

    // --------------------------------------------------------
    // NEWS LIST
    // --------------------------------------------------------

    final List<News> newsList = <News>[
      news!,
    ];

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        16.w,
        16.h,
        16.w,
        30.h,
      ),
      itemCount: newsList.length,
      separatorBuilder: (context, index) {
        return sizedBoxHeight(height: 14);
      },
      itemBuilder: (context, index) {
        final News item =  newsList[index];

        return CustomShimmer(
          isLoading: basicControllerInvest.isLoading,
          child: NewsCard(
            news: item,
            onTap: () {
              basicControllerInvest.updateNews(news: item);
              Navigator.of(context).pushNamed(
                InvestmentApp.newsDetailsScreenInvest,
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================================
// EMPTY NEWS VIEW
// ============================================================

class _EmptyNewsView extends StatelessWidget {
  const _EmptyNewsView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              color: surfaceNavy,
              shape: BoxShape.circle,
              border: Border.all(
                color: borderDark,
                width: 1.w,
              ),
            ),
            child: Icon(
              Icons.newspaper_outlined,
              color: textMuted,
              size: 42.w,
            ),
          ),
        ),
        sizedBoxHeight(height: 20),
        Center(
          child: CustomText(
            'No News Available',
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  color: textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        sizedBoxHeight(height: 8),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: CustomText(
              'There is no news available at the moment.',
              textAlign: TextAlign.center,
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    color: textSecondary,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
