import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/card_controller.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/dashboard/card/card_screen/screen/card_add_balance/add_balance_success/widget/top_up_button.dart';
import 'package:vlr/views/screens/dashboard/card/card_screen/screen/custom_appbar_card/custom_appbar_card_widget.dart';

class AddBalanceFailsScreen extends StatelessWidget {
  final String? reason;
  const AddBalanceFailsScreen({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppForCard(title: "Top-up Status"),
      bottomNavigationBar: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TopTupSuccessAndFailsButton(
              firstButtonName: "Try Again",
              firstOnTap: () {
                pop(context);
              },
              secondButtonName: "Back to Home",
              secondOnTap: () {
                pop(context);
              },
            )
          ],
        ),
      ),
      body: GetBuilder<CardController>(builder: (cardController) {
        final _topUpFailsModelList =
            topUpFailsModelList(cardController: cardController);

        return SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SvgPicture.asset(
                Assets.svgsFailure2,
                height: 96,
                width: 96,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  children: [
                    Text(
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      "Top-up Failed",
                      style: Helper(context).textTheme.displayLarge?.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      "Your request could not be processed. Please check your card details and try again.",
                      style: Helper(context).textTheme.displayLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: purpleLight,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: white2),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: black.withValues(alpha: 0.02),
                      )
                    ]),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final topUpFailedModel = _topUpFailsModelList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.start,
                              topUpFailedModel.title,
                              style: Helper(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: purpleLight,
                                  ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.end,
                                topUpFailedModel.info,
                                style: Helper(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: blueDark,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: _topUpFailsModelList.length,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                reason ?? "",
                style: Helper(context).textTheme.displayLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class TopUpFailedModel {
  final String title;
  final String info;

  TopUpFailedModel({
    required this.title,
    required this.info,
  });
}

List<TopUpFailedModel> topUpFailsModelList(
        {required CardController cardController}) =>
    [
      TopUpFailedModel(
          title: "Amount",
          info: PriceConverter.convertToNumberFormat(double.tryParse(
                  cardController.cardTapAmountController.text.trim()) ??
              0.00)),
      TopUpFailedModel(
          title: "Card Ref No",
          info: cardController.selectPrepaidCardModel?.cardRefId.toString() ??
              ""),
    ];
