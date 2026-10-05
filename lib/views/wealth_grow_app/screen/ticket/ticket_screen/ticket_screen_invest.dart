import 'package:flutter/material.dart';

import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class TicketScreenInvest extends StatelessWidget {
  const TicketScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,

      // ====================================================
      // APP BAR
      // ====================================================

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
      ),

      // ====================================================
      // BODY
      // ====================================================

     
    );
  }
}