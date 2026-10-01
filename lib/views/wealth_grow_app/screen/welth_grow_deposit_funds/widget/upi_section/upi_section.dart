import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gal/gal.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/copy_text.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class UpiScanPaySection extends StatelessWidget {
  const UpiScanPaySection({super.key});

  Future<Uint8List?> _getQrImageBytes(String imageUrl) async {
    try {
      if (imageUrl.trim().isEmpty) {
        return null;
      }

      final response = await http.get(
        Uri.parse(imageUrl),
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      }

      debugPrint(
        "QR image download failed: ${response.statusCode}",
      );

      return null;
    } catch (e) {
      debugPrint(
        "ERROR _getQrImageBytes(): $e",
      );

      return null;
    }
  }

  Future<void> _saveQrToPhone(String imageUrl) async {
    try {
      if (imageUrl.trim().isEmpty) {
        showToast(
          message: "QR image not available",
          toastType: ToastType.error,
        );
        return;
      }

      final Uint8List? bytes = await _getQrImageBytes(
        imageUrl,
      );

      if (bytes == null) {
        showToast(
          message: "Unable to download QR code",
          toastType: ToastType.error,
        );
        return;
      }

      final bool hasPermission = await Gal.requestAccess();

      if (!hasPermission) {
        showToast(
          message: "Photo permission is required",
          toastType: ToastType.warning,
        );
        return;
      }

      await Gal.putImageBytes(
        bytes,
        name: "wealthgrow_qr",
      );

      showToast(
        message: "QR code saved to your phone",
        toastType: ToastType.success,
      );
    } catch (e) {
      debugPrint(
        "ERROR _saveQrToPhone(): $e",
      );

      showToast(
        message: "Unable to save QR code",
        toastType: ToastType.error,
      );
    }
  }

  Future<void> _shareQr(String imageUrl) async {
    try {
      if (imageUrl.trim().isEmpty) {
        showToast(
          message: "QR image not available",
          toastType: ToastType.error,
        );
        return;
      }

      final Uint8List? bytes = await _getQrImageBytes(
        imageUrl,
      );

      if (bytes == null) {
        showToast(
          message: "Unable to download QR code",
          toastType: ToastType.error,
        );
        return;
      }

      final XFile qrFile = XFile.fromData(
        bytes,
        mimeType: "image/png",
      );

      final ShareResult result = await SharePlus.instance.share(
        ShareParams(
          files: [qrFile],
          text: "WealthGrow UPI QR",
          fileNameOverrides: ["wealthgrow_qr.png"],
        ),
      );

      if (result.status == ShareResultStatus.unavailable) {
        showToast(
          message: "Sharing is not available",
          toastType: ToastType.error,
        );
      }
    } catch (e) {
      debugPrint(
        "ERROR _shareQr(): $e",
      );

      showToast(
        message: "Unable to share QR code",
        toastType: ToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasicControllerInvest>(
      builder: (basicControllerInvest) {
        final String qrImageUrl = basicControllerInvest
                .appSettingInvestModel?.fundSetting?.qrImageFormat ??
            "";

        final String upiId =
            basicControllerInvest.appSettingInvestModel?.fundSetting?.upi ?? "";

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: cardDartBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: cardDartBorderColor,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CustomText(
                    "Dynamic Merchant QR",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 13.sp,
                        ),
                  ),
                ],
              ),

              sizedBoxHeight(height: 16.h),

              CustomImage(
                path: qrImageUrl,
                height: 270.h,
                width: 270.w,
                fit: BoxFit.cover,
                radius: 12.r,
              ),

              sizedBoxHeight(height: 24.h),

              // UPI ID
              GestureDetector(
                onLongPress: () {
                  if (upiId.trim().isEmpty) {
                    showToast(
                      message: "UPI ID not available",
                      toastType: ToastType.warning,
                    );
                    return;
                  }

                  copyText(
                    text: upiId,
                  );

                  showToast(
                    message: "UPI ID copied",
                    toastType: ToastType.success,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 24.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99.r),
                    color: primaryColorLight2.withValues(
                      alpha: 0.2,
                    ),
                  ),
                  child: CustomText(
                    upiId.isEmpty ? "--" : upiId,
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14.sp,
                        ),
                  ),
                ),
              ),

              sizedBoxHeight(height: 20.h),

              // Save & Share
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _saveQrToPhone(
                          qrImageUrl,
                        );
                      },
                      icon: Icon(
                        Icons.download_rounded,
                        size: 19.sp,
                      ),
                      label: CustomText(
                        "Save to Phone",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(
                          double.infinity,
                          46.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        side: const BorderSide(
                          color: cardDartBorderColor,
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(width: 10.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _shareQr(
                          qrImageUrl,
                        );
                      },
                      icon: Icon(
                        Icons.share_rounded,
                        size: 19.sp,
                        color: black,
                      ),
                      label: CustomText(
                        "Share QR",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: black,
                            ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          double.infinity,
                          46.h,
                        ),
                        backgroundColor: primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
