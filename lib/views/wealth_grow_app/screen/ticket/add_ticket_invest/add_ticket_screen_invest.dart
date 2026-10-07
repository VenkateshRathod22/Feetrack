import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/invest_controller/ticket_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class AddTicketScreenInvest extends StatefulWidget {
  const AddTicketScreenInvest({super.key});

  @override
  State<AddTicketScreenInvest> createState() =>
      _AddTicketScreenInvestState();
}

class _AddTicketScreenInvestState
    extends State<AddTicketScreenInvest> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final TicketControllerInvest ticketController;

  @override
  void initState() {
    super.initState();

    ticketController =
        Get.find<TicketControllerInvest>();
  }

  // =========================================================
  // SUBMIT TICKET
  // =========================================================

  Future<void> _submitTicket() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final result =
        await ticketController.addComplainInvest();

    if (!mounted) {
      return;
    }

    if (result.isSuccess) {
      Get.snackbar(
        'Success',
        result.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: green,
        colorText: white,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
      );

      Get.back(result: true);
      return;
    }

    Get.snackbar(
      'Error',
      result.message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: red,
      colorText: white,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
    );
  }

  // =========================================================
  // INPUT DECORATION
  // =========================================================

  InputDecoration _inputDecoration({
    required String hintText,
    required String labelText,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: cardBackground,

      labelStyle: const TextStyle(
        color: textSecondary,
      ),

      hintStyle: const TextStyle(
        color: textMuted,
      ),

      prefixIconColor: textSecondary,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: borderDark,
          width: 1.w,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: primaryColor,
          width: 1.2.w,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: red,
          width: 1.w,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: red,
          width: 1.2.w,
        ),
      ),

      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
    );
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

        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: textPrimary,
          ),
        ),

        title: CustomText(
          'Create Ticket',
          style: Helper(context)
              .textTheme
              .titleLarge
              ?.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),

      // =========================================================
      // BODY
      // =========================================================

      body: GetBuilder<TicketControllerInvest>(
        builder: (controller) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                16.w,
                8.h,
                16.w,
                30.h,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // =====================================================
                  // HEADER
                  // =====================================================

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      gradient: cardDarkGradient,
                      borderRadius:
                          BorderRadius.circular(18.r),
                      border: Border.all(
                        color: borderDark,
                        width: 1.w,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color:
                                primaryColor.withOpacity(0.10),
                            borderRadius:
                                BorderRadius.circular(14.r),
                          ),
                          child: Icon(
                            Icons.support_agent_rounded,
                            color: primaryColor,
                            size: 26.sp,
                          ),
                        ),

                        sizedBoxWidth(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'Need Help?',
                                style: Helper(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: textPrimary,
                                      fontWeight:
                                          FontWeight.w700,
                                    ),
                              ),

                              sizedBoxHeight(height: 4),

                              CustomText(
                                'Tell us about your issue and our team will review your ticket.',
                                overflow: TextOverflow.clip,
                                style: Helper(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: textSecondary,
                                      height: 1.4,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  sizedBoxHeight(height: 24),

                  // =====================================================
                  // SUBJECT
                  // =====================================================

                  CustomText(
                    'Ticket Subject',
                    style: Helper(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          color: textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),

                  sizedBoxHeight(height: 10),

                  TextFormField(
                    controller:
                        controller.subjectController,
                    textInputAction:
                        TextInputAction.next,
                    style: const TextStyle(
                      color: textPrimary,
                    ),
                    decoration: _inputDecoration(
                      labelText: 'Subject',
                      hintText:
                          'Enter your ticket subject',
                      prefixIcon: const Icon(
                        Icons.subject_rounded,
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter subject';
                      }

                      if (value.trim().length < 3) {
                        return 'Subject must be at least 3 characters';
                      }

                      return null;
                    },
                  ),

                  sizedBoxHeight(height: 20),

                  // =====================================================
                  // MESSAGE
                  // =====================================================

                  CustomText(
                    'Describe Your Issue',
                    style: Helper(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          color: textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),

                  sizedBoxHeight(height: 10),

                  TextFormField(
                    controller:
                        controller.userMessageController,
                    textInputAction:
                        TextInputAction.newline,
                    keyboardType:
                        TextInputType.multiline,
                    minLines: 6,
                    maxLines: 10,
                    style: const TextStyle(
                      color: textPrimary,
                    ),
                    decoration: _inputDecoration(
                      labelText: 'Message',
                      hintText:
                          'Explain your issue in detail...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          bottom: 78.h,
                        ),
                        child: const Icon(
                          Icons.message_outlined,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter your message';
                      }

                      if (value.trim().length < 10) {
                        return 'Please enter at least 10 characters';
                      }

                      return null;
                    },
                  ),

                  sizedBoxHeight(height: 28),

                  // =====================================================
                  // SUBMIT BUTTON
                  // =====================================================

                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : _submitTicket,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        disabledBackgroundColor:
                            primaryColor.withOpacity(0.45),
                        foregroundColor: backgroundDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14.r),
                        ),
                      ),
                      child: controller.isLoading
                          ? SizedBox(
                              width: 22.w,
                              height: 22.h,
                              child:
                                  const CircularProgressIndicator(
                                strokeWidth: 2.2,
                                color: backgroundDark,
                              ),
                            )
                          : Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send_rounded,
                                  size: 19.sp,
                                ),

                                sizedBoxWidth(width: 8),

                                CustomText(
                                  'Submit Ticket',
                                  style: Helper(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color:
                                            backgroundDark,
                                        fontWeight:
                                            FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  sizedBoxHeight(height: 14),

                  // =====================================================
                  // FOOTER MESSAGE
                  // =====================================================

                  Center(
                    child: CustomText(
                      'Our support team will review your ticket.',
                      textAlign: TextAlign.center,
                      style: Helper(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            color: textMuted,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}