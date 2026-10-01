import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/welth_grow_deposit_funds/widget/direct_bank_wire_section/direct_bank_wire_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/welth_grow_deposit_funds/widget/upi_section/upi_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/welth_grow_deposit_funds/widget/welth_grow_deposit_funds_top_section.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class WelthGrowDepositFunds extends StatefulWidget {
  const WelthGrowDepositFunds({super.key});

  @override
  State<WelthGrowDepositFunds> createState() => _WelthGrowDepositFundsState();
}

class _WelthGrowDepositFundsState extends State<WelthGrowDepositFunds> {
  late final PageController _pageController;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int index) {
    setState(() {
      selectedIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "WelthGrow Deposit Funds",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 24.sp,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelthGrowDepositFundsTopSection(),

            sizedBoxHeight(height: 20),

            // Payment method selector
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: cardDartBg,
                borderRadius: BorderRadius.circular(99.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _changePage(0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(99.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_2_rounded,
                              size: 20.sp,
                              color: selectedIndex == 0 ? black : textSecondary,
                            ),
                            sizedBoxWidth(width: 6.w),
                            CustomText(
                              "UPI Scan & Pay",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Helper(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontSize: 14.sp,
                                    color: selectedIndex == 0
                                        ? black
                                        : textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(width: 4),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _changePage(1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance_outlined,
                              size: 20.sp,
                              color: selectedIndex == 1 ? black : textSecondary,
                            ),
                            sizedBoxWidth(width: 6.w),
                            CustomText(
                              "Bank Account",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Helper(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: selectedIndex == 1
                                        ? black
                                        : textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            sizedBoxHeight(height: 16),

            // Payment pages
            ExpandablePageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: const [
                UpiScanPaySection(),
                DirectBankWireSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
