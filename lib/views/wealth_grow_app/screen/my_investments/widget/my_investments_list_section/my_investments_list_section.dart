import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/data/models/invest_model/activation_history_model_invest.dart';
import 'package:vlr/services/constants.dart';
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
    final pagination = controller.activationHistoryPagination;

    if (pagination.isInitialLoading && pagination.items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!pagination.isInitialLoading && pagination.items.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 150),
          Center(
            child: Text(
              "No active investments found",
            ),
          ),
        ],
      );
    }

    final int itemCount =
        pagination.items.length + (pagination.isMoreLoading ? 1 : 0);

    return ListView.separated(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => sizedBoxHeight(height: 14.h),
      itemBuilder: (context, index) {
        // Bottom loading indicator
        if (index >= pagination.items.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final ActivationHistoryModelInvest item = pagination.items[index];

        return InvestmentsCardWidget(activationHistoryModelInvest: item);
      },
    );
  }

  Widget _buildCompletedList(
    InvestmentControllerInvest controller,
  ) {
    final items = controller.historyInvestmentModelInvestList;

    if (controller.isLoading && items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!controller.isLoading && items.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 150),
          Center(
            child: Text(
              "No completed investments found",
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => sizedBoxHeight(height: 14.h),
      itemBuilder: (context, index) {
        final item = items[index];

        return InvestmentsCardWidget(activationHistoryModelInvest: item);
      },
    );
  }
}
