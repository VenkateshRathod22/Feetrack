import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/data/models/invest_model/home_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback onTap;

  const NewsCard({
    super.key,
    required this.news,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: cardDarkGradient,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: borderDark,
            width: 1.w,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // NEWS IMAGE
            // ==================================================

            NewsImage(
              image: news.newimage,
            ),

            // ==================================================
            // CONTENT
            // ==================================================

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------------------------------------
                  // NEWS TITLE
                  // ------------------------------------------------

                  CustomText(
                    _getTitle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        Helper(context).textTheme.titleMedium?.copyWith(
                              color: textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                  ),

                  sizedBoxHeight(height: 8),

                  // ------------------------------------------------
                  // NEWS DESCRIPTION
                  // ------------------------------------------------

                  CustomText(
                    _getDescription(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style:
                        Helper(context).textTheme.bodyMedium?.copyWith(
                              color: textSecondary,
                              height: 1.5,
                            ),
                  ),

                  sizedBoxHeight(height: 14),

                  // ------------------------------------------------
                  // READ MORE
                  // ------------------------------------------------

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        'Read More',
                        style:
                            Helper(context).textTheme.bodySmall?.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      sizedBoxWidth(width: 5),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: primaryColor,
                        size: 16.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    final String value = news.news?.trim() ?? '';

    if (value.isEmpty) {
      return 'News';
    }

    // Current API does not have a separate title field for News.
    // Use a short title from the first part of the news text.
    if (value.length <= 45) {
      return value;
    }

    return '${value.substring(0, 45)}...';
  }

  String _getDescription() {
    final String value = news.news?.trim() ?? '';

    if (value.isEmpty) {
      return 'No news details available.';
    }

    return value;
  }
}

// ============================================================
// NEWS IMAGE
// ============================================================

class NewsImage extends StatelessWidget {
  final String? image;

  const NewsImage({
    super.key,
    required this.image,
  });

  String? get imageUrl {
    final String value = image?.trim() ?? '';

    if (value.isEmpty) {
      return null;
    }

    // Already a complete URL
    if (value.startsWith('http://') ||
        value.startsWith('https://')) {
      return value;
    }

    String path = value;

    // Remove ../ when API returns it
    while (path.startsWith('../')) {
      path = path.substring(3);
    }

    // Remove starting slash
    if (path.startsWith('/')) {
      path = path.substring(1);
    }

    return 'https://investor.feetrack.in/$path';
  }

  @override
  Widget build(BuildContext context) {
    final String? url = imageUrl;

    // =========================================================
    // NO IMAGE
    // =========================================================

    if (url == null) {
      return Container(
        width: double.infinity,
        height: 190.h,
        color: surfaceNavy,
        child: Center(
          child: Icon(
            Icons.newspaper_outlined,
            color: primaryColor,
            size: 55.w,
          ),
        ),
      );
    }

    // =========================================================
    // NETWORK IMAGE
    // =========================================================

    return SizedBox(
      width: double.infinity,
      height: 190.h,
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return Container(
            color: surfaceNavy,
            child: Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: textMuted,
                size: 42.w,
              ),
            ),
          );
        },
        loadingBuilder: (
          context,
          child,
          loadingProgress,
        ) {
          if (loadingProgress == null) {
            return child;
          }

          return Container(
            color: surfaceNavy,
            child: const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 2,
              ),
            ),
          );
        },
      ),
    );
  }
}