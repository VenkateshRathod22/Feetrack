import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/invest_controller/ticket_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/ticket/add_ticket_invest/add_ticket_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/ticket/ticket_screen/widget/ticket_card_invest.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';


class TicketScreenInvest extends StatefulWidget {
  const TicketScreenInvest({super.key});

  @override
  State<TicketScreenInvest> createState() =>
      _TicketScreenInvestState();
}

class _TicketScreenInvestState extends State<TicketScreenInvest> {
  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<TicketControllerInvest>().fetchTicketInvest();
    });
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,

      // =========================================================
      // APP BAR
      // =========================================================

      appBar: AppBar(
        backgroundColor: backgroundDark,
        elevation: 0,
        centerTitle: false,

        title: CustomText(
          'My Tickets',
          style: Helper(context).textTheme.titleLarge?.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),

        iconTheme: const IconThemeData(
          color: textPrimary,
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: IconButton(
              onPressed: () async {
                final result = await Get.to(
                  () => const AddTicketScreenInvest(),
                );

                if (result == true) {
                  await Get.find<TicketControllerInvest>()
                      .fetchTicketInvest();
                }
              },
              icon: Icon(
                Icons.add_circle_outline_rounded,
                color: primaryColor,
                size: 26.sp,
              ),
              tooltip: 'Create Ticket',
            ),
          ),
        ],
      ),

      // =========================================================
      // BODY
      // =========================================================

      body: GetBuilder<TicketControllerInvest>(
        builder: (controller) {
          // =========================================================
          // INITIAL LOADING
          // =========================================================

          if (controller.isLoading &&
              controller.ticketList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          // =========================================================
          // TICKET LIST
          // =========================================================

          if (controller.ticketList.isNotEmpty) {
            return RefreshIndicator(
              color: primaryColor,
              backgroundColor: surfaceNavy,
              onRefresh: controller.refreshTickets,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  16.h,
                  16.w,
                  30.h,
                ),
                itemCount: controller.ticketList.length,
                separatorBuilder: (_, __) {
                  return sizedBoxHeight(height: 14);
                },
                itemBuilder: (context, index) {
                  final ticket = controller.ticketList[index];

                  return TicketCardInvest(
                    ticket: ticket,
                  );
                },
              ),
            );
          }

          // =========================================================
          // EMPTY STATE
          // =========================================================

          return RefreshIndicator(
            color: primaryColor,
            backgroundColor: surfaceNavy,
            onRefresh: controller.refreshTickets,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 16.h,
              ),
              children: [
                SizedBox(
                  height: 100.h,
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: cardBackground,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: borderDark,
                      width: 1.w,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 72.w,
                        height: 72.h,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.10),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.support_agent_rounded,
                          color: primaryColor,
                          size: 36.sp,
                        ),
                      ),

                      sizedBoxHeight(height: 18),

                      CustomText(
                        'No Tickets Yet',
                        textAlign: TextAlign.center,
                        style: Helper(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),

                      sizedBoxHeight(height: 8),

                      CustomText(
                        'Create a ticket whenever you need help or want to report an issue.',
                        textAlign: TextAlign.center,
                        style: Helper(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: textSecondary,
                              height: 1.5,
                            ),
                      ),

                      sizedBoxHeight(height: 22),

                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final result = await Get.to(
                              () => const AddTicketScreenInvest(),
                            );

                            if (result == true) {
                              await Get.find<TicketControllerInvest>()
                                  .fetchTicketInvest();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: backgroundDark,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14.r),
                            ),
                          ),
                          icon: Icon(
                            Icons.add_rounded,
                            size: 20.sp,
                          ),
                          label: CustomText(
                            'Create Ticket',
                            style: Helper(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: backgroundDark,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}