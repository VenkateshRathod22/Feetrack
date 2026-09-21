import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/card_controller.dart';
import 'package:vlr/controllers/card_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/screens/dashboard/card/card_screen/screen/card_balance_inquiry/widget/card_balance_card_info_section.dart';
import 'package:vlr/views/screens/dashboard/card/card_screen/screen/card_balance_inquiry/widget/card_balance_info_section.dart';
import 'package:vlr/views/screens/dashboard/card/card_screen/screen/card_balance_inquiry/widget/card_balance_inqu_TopSection.dart';
import 'package:vlr/views/screens/dashboard/card/card_screen/screen/custom_appbar_card/custom_appbar_card_widget.dart';

class CardBalanceInquiryScreen extends StatefulWidget {
  const CardBalanceInquiryScreen({super.key});

  @override
  State<CardBalanceInquiryScreen> createState() =>
      _CardBalanceInquiryScreenState();
}

class _CardBalanceInquiryScreenState extends State<CardBalanceInquiryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CardController>()
          .fetchPrepaidCardBalanceInquiry(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppForCard(title: "Balance Details"),
      bottomNavigationBar: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              radius: 12,
              color: secondaryColor,
              height: 48,
              onTap: () {
                pop(context);
              },
              child: Text(
                "Back to Card",
                style: Helper(context).textTheme.displayLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardBalaceInquTopSection(),
            CardBalanceInfoSection(),
            SizedBox(
              height: 56,
            ),
            CardBalanceInquCardInfoSection(),
          ],
        ),
      ),
    );
  }
}
