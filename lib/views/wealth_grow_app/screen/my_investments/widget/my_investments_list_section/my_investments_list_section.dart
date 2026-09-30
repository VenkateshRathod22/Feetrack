import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/data/models/invest_model/activation_history_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/wealth_grow_app/screen/my_investments/widget/my_investments_list_section/investments_card_widget.dart';

class MyInvestmentsListSection extends StatelessWidget {
  final bool isActive;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;

  const MyInvestmentsListSection({
    super.key,
    required this.isActive,
    required this.scrollController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvestmentControllerInvest>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: isActive
              ? _buildActiveList(controller)
              : _buildCompletedList(controller),
        );
      },
    );
  }

  Widget _buildActiveList(
    InvestmentControllerInvest controller,
  ) {
    List<ActivationHistoryModelInvest> items = controller
        .historyInvestmentModelInvestList
        .where((e) => !e.withdrawStatusFormat)
        .toList();

    if (!controller.isLoading && items.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          sizedBoxHeight(height: 150),
          const Center(
            child: Text(
              "No Active investments found",
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: controller.isLoading ? 4 : items.length,
      separatorBuilder: (_, __) => sizedBoxHeight(height: 14.h),
      itemBuilder: (context, index) {
        final ActivationHistoryModelInvest item = controller.isLoading
            ? ActivationHistoryModelInvest()
            : items[index];

        return CustomShimmer(
            isDarkMode: true,
            isLoading: controller.isLoading,
            child: InvestmentsCardWidget(activationHistoryModelInvest: item));
      },
    );
  }

  Widget _buildCompletedList(
    InvestmentControllerInvest controller,
  ) {
    List<ActivationHistoryModelInvest> items = controller
        .historyInvestmentModelInvestList
        .where((e) => e.withdrawStatusFormat)
        .toList();
    if (!controller.isLoading && items.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          sizedBoxHeight(height: 150),
          const Center(
            child: Text(
              "No Withdraws investments found",
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: controller.isLoading ? 4 : items.length,
      separatorBuilder: (_, __) => sizedBoxHeight(height: 14.h),
      itemBuilder: (context, index) {
        final ActivationHistoryModelInvest item = controller.isLoading
            ? ActivationHistoryModelInvest()
            : items[index];

        return CustomShimmer(
            isDarkMode: true,
            isLoading: controller.isLoading,
            child: InvestmentsCardWidget(activationHistoryModelInvest: item));
      },
    );
  }
}
