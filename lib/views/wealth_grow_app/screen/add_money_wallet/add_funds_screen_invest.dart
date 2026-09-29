// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:vlr/controllers/invest_controller/wallet_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class AddFundsScreenInvest extends StatelessWidget {
  AddFundsScreenInvest({super.key});

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickScreenshot(
    BuildContext context,
    WalletControllerInvest controller,
  ) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) {
        return;
      }

      controller.setFundScreenshot(
        File(image.path),
      );
    } catch (e) {
      showToast(
        message: 'Unable to select screenshot',
        typeCheck: false,
      );
    }
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
        ),
        sizedBoxHeight(height: 4),
        CustomText(
          subtitle,
          style: Helper(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildScreenshotSection(
    BuildContext context,
    WalletControllerInvest controller,
  ) {
    final File? screenshot = controller.fundScreenshot;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'Transaction Screenshot',
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: textSecondary,
              ),
        ),
        sizedBoxHeight(height: 7),
        if (screenshot == null)
          InkWell(
            borderRadius: BorderRadius.circular(14.r),
            onTap: () => _pickScreenshot(
              context,
              controller,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 22.h,
              ),
              decoration: BoxDecoration(
                color: surfaceNavy,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: borderDark,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 52.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(
                        alpha: 0.10,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.cloud_upload_outlined,
                      color: primaryColor,
                      size: 26.w,
                    ),
                  ),
                  sizedBoxHeight(height: 12),
                  CustomText(
                    'Upload Transaction Screenshot',
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: textPrimary,
                        ),
                  ),
                  sizedBoxHeight(height: 4),
                  CustomText(
                    'Upload the screenshot after completing your payment',
                    textAlign: TextAlign.center,
                    style: Helper(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: textMuted,
                        ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: surfaceNavy,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: primaryColor.withValues(
                  alpha: 0.35,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(14.r),
                  ),
                  child: Image.file(
                    screenshot,
                    width: double.infinity,
                    height: 220.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          screenshot.path.split('/').last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: textSecondary,
                              ),
                        ),
                      ),
                      sizedBoxWidth(width: 8),
                      GestureDetector(
                        onTap: controller.removeFundScreenshot,
                        child: Container(
                          width: 36.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            color: red.withValues(
                              alpha: 0.10,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: red,
                            size: 19.w,
                          ),
                        ),
                      ),
                      sizedBoxWidth(width: 8),
                      GestureDetector(
                        onTap: () => _pickScreenshot(
                          context,
                          controller,
                        ),
                        child: Container(
                          width: 36.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(
                              alpha: 0.10,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.refresh,
                            color: primaryColor,
                            size: 19.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFundInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: primaryColor.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: primaryColor.withValues(
            alpha: 0.20,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: primaryColor,
            size: 20.w,
          ),
          sizedBoxWidth(width: 10),
          Expanded(
            child: CustomText(
              'First transfer the amount to the company account. '
              'After completing the transaction, submit the transaction ID '
              'and payment screenshot here.',
              style: Helper(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    height: 1.5,
                    color: textSecondaryLight,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,

      appBar: AppBar(
        backgroundColor: backgroundDark,
        elevation: 0,
        centerTitle: false,
        title: CustomText(
          'Add Funds',
          style: Helper(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
        ),
      ),

      body: GetBuilder<WalletControllerInvest>(
        builder: (controller) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: AppConstants.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFundInfoCard(context),

                sizedBoxHeight(height: 24),

                _buildSectionTitle(
                  context,
                  'PAYMENT DETAILS',
                  'Enter the details of your completed payment',
                ),

                sizedBoxHeight(height: 18),

                // =================================================
                // AMOUNT
                // =================================================

                AppTextFieldWithHeading(
                  controller: controller.fundAmountController,
                  headingWidget: CustomText(
                    'Amount',
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: textSecondary,
                        ),
                  ),
                  hindText: 'Enter amount',
                  isRequired: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.next,
                  prefixText: '₹ ',
                  prefixStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                  bgColor: surfaceNavy,
                  borderColor: borderDark,
                  borderWidth: 1,
                  borderRadius: 14,
                  textStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: textPrimary,
                      ),
                  hintStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: textMuted,
                      ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                ),

                sizedBoxHeight(height: 18),

                // =================================================
                // TRANSACTION ID
                // =================================================

                AppTextFieldWithHeading(
                  controller: controller.transactionIdController,
                  headingWidget: CustomText(
                    'Transaction ID',
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: textSecondary,
                        ),
                  ),
                  hindText: 'Enter transaction ID / UTR number',
                  isRequired: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  bgColor: surfaceNavy,
                  borderColor: borderDark,
                  borderWidth: 1,
                  borderRadius: 14,
                  textStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: textPrimary,
                      ),
                  hintStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: textMuted,
                      ),
                ),

                sizedBoxHeight(height: 18),

                // =================================================
                // PAYMENT MODE - TEXTBOX
                // =================================================

                AppTextFieldWithHeading(
                  controller: controller.fundModeController,
                  headingWidget: CustomText(
                    'Payment Mode',
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: textSecondary,
                        ),
                  ),
                  hindText: 'Enter payment mode',
                  isRequired: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  bgColor: surfaceNavy,
                  borderColor: borderDark,
                  borderWidth: 1,
                  borderRadius: 14,
                  textStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: textPrimary,
                      ),
                  hintStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: textMuted,
                      ),
                ),

                sizedBoxHeight(height: 18),

                // =================================================
                // REMARK
                // =================================================

                AppTextFieldWithHeading(
                  controller: controller.fundRemarkController,
                  headingWidget: CustomText(
                    'Remark',
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: textSecondary,
                        ),
                  ),
                  hindText: 'Enter remark (optional)',
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                  bgColor: surfaceNavy,
                  borderColor: borderDark,
                  borderWidth: 1,
                  borderRadius: 14,
                  textStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: textPrimary,
                      ),
                  hintStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: textMuted,
                      ),
                ),

                sizedBoxHeight(height: 22),

                // =================================================
                // SCREENSHOT
                // =================================================

                _buildScreenshotSection(
                  context,
                  controller,
                ),

                sizedBoxHeight(height: 24),

                // =================================================
                // NOTE
                // =================================================

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: surfaceNavy,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: borderDark,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: green,
                        size: 18.w,
                      ),
                      sizedBoxWidth(width: 10),
                      Expanded(
                        child: CustomText(
                          'Your fund request will be reviewed after '
                          'the transaction is verified.',
                          style: Helper(context).textTheme.bodySmall?.copyWith(
                                fontSize: 11.sp,
                                color: textSecondary,
                                height: 1.4,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),

                sizedBoxHeight(height: 110),
              ],
            ),
          );
        },
      ),

      // ==========================================================
      // SUBMIT BUTTON
      // ==========================================================

      bottomNavigationBar: GetBuilder<WalletControllerInvest>(
        builder: (controller) {
          return Container(
            padding: EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              12.h,
              AppConstants.horizontalPadding,
              12.h,
            ),
            decoration: BoxDecoration(
              color: surfaceNavy,
              border: Border(
                top: BorderSide(
                  color: borderDark,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: CustomButton(
                onTap: () async {
                  if (controller.isLoading) {
                    return;
                  }

                  await controller.sendRequestForWalletFund();
                },
                height: 56,
                radius: 18,
                gradient: goldGradient,
                borderColor: primaryColor,
                isLoading: controller.isLoading,
                child: CustomText(
                  controller.isLoading ? 'Submitting...' : 'Send Fund Request',
                  style: Helper(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: neutralColor,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
