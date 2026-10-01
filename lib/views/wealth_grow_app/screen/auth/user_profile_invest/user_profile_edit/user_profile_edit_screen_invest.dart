import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class UserProfileEditScreenInvest extends StatefulWidget {
  const UserProfileEditScreenInvest({super.key});

  @override
  State<UserProfileEditScreenInvest> createState() =>
      _UserProfileEditScreenInvestState();
}

class _UserProfileEditScreenInvestState
    extends State<UserProfileEditScreenInvest> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = Get.find<AuthControllerInvest>();
      authController.nameController.text =
          authController.userModelInvest?.name ?? "";
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "Edit Profile",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 24.sp,
              ),
        ),
      ),
      bottomNavigationBar:
          GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
        return Padding(
          padding: AppConstants.screenPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                isLoading: authControllerInvest.isLoading,
                height: 60.h,
                radius: 20.r,
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    authControllerInvest.updateProfileInvest().then((value) {
                      if (value.isSuccess) {
                        authControllerInvest.fetchProfileInvest();
                        Navigator.pop(context);
                        showToast(
                            message: value.message, typeCheck: value.isSuccess);
                      } else {
                        showToast(
                            message: value.message, typeCheck: value.isSuccess);
                      }
                    });
                  }
                },
                borderColor: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      "Save Changes",
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14.sp,
                            color: black,
                          ),
                    ),
                    sizedBoxWidth(width: 8.w),
                    Icon(
                      Icons.arrow_forward,
                      color: black,
                      size: 18.sp,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
      body: GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
        return SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      authControllerInvest.selectProfileImage();
                    },
                    child: Container(
                      height: 100.w,
                      width: 100.w,
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor,
                          width: 2.w,
                        ),
                      ),
                      child: ClipOval(
                        child: authControllerInvest.selectedProfileImage != null
                            ? Image.file(
                                authControllerInvest.selectedProfileImage!,
                                height: 92.w,
                                width: 92.w,
                                fit: BoxFit.cover,
                              )
                            : CustomImage(
                                path: authControllerInvest
                                        .userModelInvest?.profileImage ??
                                    "",
                                height: 92.w,
                                width: 92.w,
                                fit: BoxFit.cover,
                                isProfile: true,
                              ),
                      ),
                    ),
                  ),
                  sizedBoxHeight(height: 16.h),
                  CustomText(
                    authControllerInvest.userModelInvest?.email ?? "",
                    style: Helper(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 14.sp, color: textPrimary1),
                  ),
                  sizedBoxHeight(height: 32.h),
                  AppTextFieldWithHeading(
                    controller: authControllerInvest.nameController,
                    hindText: "Enter full name",
                    headingWidget: CustomText(
                      "Full Name",
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 13.sp,
                          ),
                    ),
                    suffix: Icon(
                      Icons.edit_outlined,
                      size: 20.sp,
                      color: primaryColorLight2,
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a full name";
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
