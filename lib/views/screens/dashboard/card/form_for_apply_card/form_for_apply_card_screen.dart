// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/basic_controller.dart';
import 'package:vlr/controllers/card_controller.dart';
import 'package:vlr/controllers/permission_controller.dart';
import 'package:vlr/controllers/card_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/screens/auth_screens/otp_verification_screen.dart';
import 'package:vlr/views/screens/dashboard/card/form_for_apply_card/widget/applicant_identity_section.dart';
import 'package:vlr/views/screens/dashboard/card/form_for_apply_card/widget/context_info_section.dart';
import 'package:vlr/views/screens/dashboard/card/form_for_apply_card/widget/ovd_verification_section.dart';
import 'package:vlr/views/screens/dashboard/card/form_for_apply_card/widget/residential_address_section.dart';

class FormForApplyCardScreen extends StatefulWidget {
  const FormForApplyCardScreen({super.key});

  @override
  State<FormForApplyCardScreen> createState() => _FormForApplyCardScreenState();
}

class _FormForApplyCardScreenState extends State<FormForApplyCardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<BasicController>().fetchStatusList();
      await Get.find<PermissionController>()
          .requestLocationPermissionAndFetch(context);
      final cardController = Get.find<CardController>();
      cardController.updateGender("Male");
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteAppbar,
        centerTitle: true,
        title: Text(
          "New Card Application",
          style: Helper(context).textTheme.displayLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ApplicantIdentitySection(),
              SizedBox(height: 40),
              ContextInfoSection(),
              SizedBox(height: 40),
              OvdVerificationSection(),
              SizedBox(height: 40),
              ResidentialAddressSection(),
              SizedBox(height: 40),
              // CardPreferencesSection(),
              // SizedBox(height: 40),
              GetBuilder<CardController>(builder: (cardController) {
                return CustomButton(
                  isLoading: cardController.isLoading,
                  onTap: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await cardController
                          .cardCustomOnBoarding()
                          .then((value) async {
                        if (value.isSuccess) {
                          showToast(message: value.message);

                          await cardController
                              .generateOTPForPrepaidCard(
                                
                                  // context: context,
                                  number: cardController.numberController.text
                                      .trim())
                              .then((value) {
                            if (value.isSuccess) {
                              navigate(
                                  context: context,
                                  page: OTPVerificationPrepaidCard(
                                    phone: cardController.numberController.text
                                        .trim(),
                                    isForPrepaidCardApplyForm: true,
                                  ));
                              showToast(
                                  message: value.message,
                                  typeCheck: value.isSuccess);
                            } else {
                              showToast(
                                  message: value.message,
                                  typeCheck: value.isSuccess);
                            }
                          });
                        } else {
                          showToast(message: value.message);
                        }
                      });
                    }
                  },
                  height: 60,
                  radius: 12,
                  child: Text(
                    "Apply for Card",
                    style: Helper(context).textTheme.displayLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: white,
                        ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
