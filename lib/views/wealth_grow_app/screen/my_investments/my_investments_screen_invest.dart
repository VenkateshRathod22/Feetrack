import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/my_investments/widget/filter_selection_section/filter_selection_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/my_investments/widget/my_investments_list_section/my_investments_list_section.dart';

class MyInvestmentsScreenInvest extends StatefulWidget {
  const MyInvestmentsScreenInvest({
    super.key,
  });

  @override
  State<MyInvestmentsScreenInvest> createState() =>
      _MyInvestmentsScreenInvestState();
}

class _MyInvestmentsScreenInvestState extends State<MyInvestmentsScreenInvest> {
  int selectedIndex = 0;

  final ScrollController scrollController = ScrollController();

  InvestmentControllerInvest get investmentController =>
      Get.find<InvestmentControllerInvest>();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSelectedList();
    });
  }

  void _onScroll() {
    if (selectedIndex != 0) {
      return;
    }

    if (!scrollController.hasClients) {
      return;
    }

    final position = scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      investmentController.fetchActivationHistory(
        loadMore: true,
      );
    }
  }

  Future<void> _loadSelectedList() async {
    if (selectedIndex == 0) {
      await investmentController.fetchActivationHistory();
    } else {
      await investmentController.fetchHistoryInvestmentInvest();
    }
  }

  Future<void> _onFilterChanged(int index) async {
    if (selectedIndex == index) {
      return;
    }

    setState(() {
      selectedIndex = index;
    });

    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }

    await _loadSelectedList();
  }

  Future<void> _onRefresh() async {
    await _loadSelectedList();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "My Investments",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 24.sp,
              ),
        ),
      ),
      body: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            sizedBoxHeight(height: 12.h),
            FilterSelectionSection(
              selectedIndex: selectedIndex,
              onSelected: _onFilterChanged,
            ),
            sizedBoxHeight(height: 16.h),
            
            Expanded(
              child: MyInvestmentsListSection(
                isActive: selectedIndex == 0,
                scrollController: scrollController,
                onRefresh: _onRefresh,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
