import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/card_controller.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/extensions.dart';

import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_dropdown.dart';
import 'package:vlr/views/screens/dashboard/card/form_for_apply_card/widget/card_form_heading_text.dart';
import 'package:vlr/views/screens/dashboard/card/form_for_apply_card/widget/card_form_title_row.dart';

import 'package:vlr/views/widget/text_box/app_text_box.dart';

class OvdVerificationSection extends StatelessWidget {
  const OvdVerificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(builder: (cardController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardFormTitleRow(
              icon: Assets.svgsSecurity2, title: "OVD Verification"),
          SizedBox(height: 20),
          CustomDropDownList(
            items: cardController.ovdList,
            itemWidget: cardController.ovdListText
                .map((e) => Text(e,
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: black,
                        )))
                .toList(),
            value: cardController.ovd,
            headingWidget: CardFormHeadingText(
              heading: "OVD TYPE",
            ),
            hintText: "Select OVD type",
            onChanged: (value) => cardController.updateOVD(value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select OVD type document";
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          AppTextFieldWithHeading(
            headingWidget: CardFormHeadingText(heading: "OVD ID"),
            controller: cardController.ovdIDController,
            keyboardType: cardController.ovd == "Aadhaar Card"
                ? TextInputType.number
                : TextInputType.emailAddress,
            inputFormatters: cardController.ovd == "Aadhaar Card"
                ? [
                    LengthLimitingTextInputFormatter(12),
                    FilteringTextInputFormatter.digitsOnly
                  ]
                : [],
            hindText: "Enter Document ID",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Enter Document ID';
              }
              if (cardController.ovd == "Aadhaar Card") {
                if (value.length != 12) {
                  return 'Addhaar card have 12 digit number';
                }
              }
              if (cardController.ovd == "Pan Card") {
                if (!validatePANCard(value)) {
                  return 'Invalid PAN card format';
                }
              }

              return null;
            },
          ),
        ],
      );
    });
  }
}
