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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TicketControllerInvest controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find<TicketControllerInvest>();
    controller.clearAddTicketForm();
  }

  Future<void> _submitTicket() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final response = await controller.addComplainInvest();

    if (!mounted) return;

    if (response.isSuccess) {
      Get.back(result: true);
    } else {
      showToast(
        message: response.message,
        typeCheck: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        elevation: 0,
        title: CustomText(
          'Create Ticket',
          style: Helper(context).textTheme.titleLarge?.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        
      ),
      body: GetBuilder<TicketControllerInvest>(
        builder: (controller) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: AppConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      gradient: cardDarkGradient,
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: borderDark,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14.r),

                          ),
                          child: Icon(
                            Icons.support_agent_rounded,
                            color: primaryColor,
                            size: 25.w,
                          ),
                        ),
                        sizedBoxWidth(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'How can we help?',
                                style: Helper(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: textPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              sizedBoxHeight(height: 4),
                              CustomText(
                                'Submit your issue and our team will assist you.',
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

                  sizedBoxHeight(height: 26),

                  CustomText(
                    'Ticket Subject',
                    style: Helper(context).textTheme.titleSmall?.copyWith(
                          color: textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),

                  sizedBoxHeight(height: 10),

                  TextFormField(
                    controller: controller.subjectController,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 14.sp,
                    ),
                    decoration: _inputDecoration(
                      hint: 'Enter ticket subject',
                      icon: Icons.subject_rounded,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a subject';
                      }
                      return null;
                    },
                  ),

                  sizedBoxHeight(height: 22),

                  CustomText(
                    'Describe Your Issue',
                    style: Helper(context).textTheme.titleSmall?.copyWith(
                          color: textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),

                  sizedBoxHeight(height: 10),

                  TextFormField(
                    controller: controller.userMessageController,
                    minLines: 5,
                    maxLines: 8,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                    decoration: _inputDecoration(
                      hint:
                          'Explain your issue in detail...',
                      icon: Icons.message_outlined,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please describe your issue';
                      }

                      if (value.trim().length < 10) {
                        return 'Please enter at least 10 characters';
                      }

                      return null;
                    },
                  ),

                  sizedBoxHeight(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : _submitTicket,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        disabledBackgroundColor:
                            primaryColor.withValues(alpha: 0.5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: controller.isLoading
                          ? SizedBox(
                              width: 22.w,
                              height: 22.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: neutralColor,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send_rounded,
                                  color: neutralColor,
                                  size: 18.w,
                                ),
                                sizedBoxWidth(width: 9),
                                CustomText(
                                  'Submit Ticket',
                                  style: Helper(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: neutralColor,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  sizedBoxHeight(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: textMuted,
        fontSize: 13.sp,
      ),
      prefixIcon: Icon(
        icon,
        color: textSecondary,
        size: 20.w,
      ),
      filled: true,
      fillColor: surfaceNavy,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 16.h,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(
          color: borderDark,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(
          color: borderDark,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(
          color: red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(
          color: red,
        ),
      ),
    );
  }
}